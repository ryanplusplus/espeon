local datafile = require 'datafile'
local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'
local shell = require 'espeon.util.shell'

local init_lua = datafile.path('res/init.lua')

return {
  description = 'Upload the source and data specified in ./espeon.conf if no arguments are provided; upload the specified file if an argument is provided',

  execute = function(arg)
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local reset = 'nodemcu-tool --port ' .. serial_port .. ' reset && sleep 1.1'

    if #arg == 1 then
      local commands = {
        reset,
        'nodemcu-tool --port ' .. serial_port .. ' remove init.lua'
      }

      if data ~= '' then
        table.insert(commands, reset)
        table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --keeppath ' .. data)
      end

      if source ~= '' then
        local sources = shell('echo ' .. source)
        for source in sources:gmatch('%S+') do
          table.insert(commands, reset)
          table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --keeppath --compile ' .. source)
        end
      end

      table.insert(commands, reset)
      table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload ' .. init_lua)

      exec(commands)
    else
      local file = arg[2]
      local is_source = file:sub(-4) == '.lua'
      local options = is_source and '--keeppath --compile' or '--keeppath'

      exec({
        reset,
        'nodemcu-tool --port ' .. serial_port .. ' upload ' .. options .. ' ' .. arg[2]
      })
    end
  end
}
