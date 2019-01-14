local datafile = require 'datafile'
local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'
local shell = require 'espeon.util.shell'
local amalg = require 'espeon.util.amalg'
local build_lfs = require 'espeon.util.build_lfs'
local compile = require 'espeon.util.compile'

local init_lua = datafile.path('res/init.lua')
local amalg_init_lua = datafile.path('res/amalg_init.lua')
local lfs_init_lua = datafile.path('res/lfs_init.lua')

local lfs_probe_lua = datafile.path('res/lfs_probe.lua')

return {
  description = 'Upload the source and data specified in ./espeon.conf',

  execute = function()
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local reset = 'nodemcu-tool --port ' .. serial_port .. ' reset'
    local reset_and_wait = reset .. ' && sleep 1.0 && exit 1'

    local function try_hard(command)
      return command .. ' > /dev/null 2>&1 || (' .. reset_and_wait .. ') || ' .. command .. ' > /dev/null 2>&1 || (' .. reset_and_wait .. ') || ' .. command
    end

    print('Preparing for upload...')
    exec({ reset, try_hard('nodemcu-tool --port ' .. serial_port .. ' remove init.lua'), reset })

    if data ~= '' then
      local expanded_data = shell('echo ' .. data)

      local datas = {}
      for data in expanded_data:gmatch('%S+') do
        print('Uploading ' .. data)
        exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --keeppath ' .. data))
      end
    end

    if source ~= '' then
      local expanded_source = shell('echo ' .. source)

      local sources = {}
      for source in expanded_source:gmatch('%S+') do
        table.insert(sources, source)
      end

      if config.lfs then
        print('Uploading LFS image...')

        exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload ' .. lfs_probe_lua))

        local base, mapped
        local attempts = 3
        while attempts > 0 and not (base and mapped) do
          pcall(function()
            base, mapped = shell('nodemcu-tool --port ' .. serial_port .. ' run lfs_probe.lua'):match('\n%w+\t(%d+)\t(%d+)')
          end)
          attempts = attempts - 1
        end

        if not (base and mapped) then
          print('Failed to detect LFS-capable firmware')
          os.exit(1)
        end

        local lfs = build_lfs(sources, base)
        exec('esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash ' .. mapped .. ' ' .. lfs)
      elseif config.amalg then
        print('Uploading source...')
        local bin = compile(amalg(sources))
        exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename app.lc ' .. bin))
      else
        for _, source in ipairs(sources) do
          print('Uploading ' .. source .. '...')
          local bin = compile(source)
          exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename ' .. source:gsub('lua$', 'lc') .. ' ' .. bin))
        end
      end
    end

    local init do
      if config.lfs then
        init = lfs_init_lua
      elseif config.amalg then
        init = amalg_init_lua
      else
        init = init_lua
      end
    end

    print('Finalizing upload...')
    exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename init.lua ' .. init))

    print()
  end
}
