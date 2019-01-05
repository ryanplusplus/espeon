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

local function try_hard(command)
  return command .. ' || ' .. command .. ' || ' .. command
end

return {
  description = 'Upload the source and data specified in ./espeon.conf',

  execute = function(arg)
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local reset = 'nodemcu-tool --port ' .. serial_port .. ' reset && sleep 0.5'

    local commands = {
      reset,
      try_hard('nodemcu-tool --port ' .. serial_port .. ' remove init.lua')
    }

    if data ~= '' then
      table.insert(commands, reset)
      table.insert(commands, try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --keeppath ' .. data))
    end

    if source ~= '' then
      local expanded_source = shell('echo ' .. source)

      local sources = {}
      for source in expanded_source:gmatch('%S+') do
        table.insert(sources, source)
      end

      if config.lfs then
        exec(try_hard('nodemcu-tool --port ' .. serial_port .. ' upload ' .. lfs_probe_lua))
        local base, mapped = shell(try_hard('nodemcu-tool --port ' .. serial_port .. ' run lfs_probe.lua')):match('\n%d+\t(%d+)\t(%d+)')

        local lfs = build_lfs(sources, base)
        table.insert(commands, try_hard('esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash ' .. mapped .. ' ' .. lfs))
      elseif config.amalg then
        local bin = compile(amalg(sources))
        table.insert(commands, reset)
        table.insert(commands, try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename app.lc ' .. bin))
      else
        for _, source in ipairs(sources) do
          local bin = compile(source)
          table.insert(commands, reset)
          table.insert(commands, try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename ' .. source:gsub('lua$', 'lc') .. ' ' .. bin))
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

    table.insert(commands, reset)
    table.insert(commands, try_hard('nodemcu-tool --port ' .. serial_port .. ' upload --remotename init.lua ' .. init))

    exec(commands)
  end
}
