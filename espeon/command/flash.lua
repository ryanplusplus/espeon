local datafile = require 'datafile'
local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'

local init_lua = datafile.path('res/init.lua')

return {
  description = 'Flash the firmware specified in ./espeon.conf to a connected ESP',

  execute = function()
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local reset = 'nodemcu-tool --port ' .. serial_port .. ' reset && sleep 1.1'

    local commands = {
      reset,
      'nodemcu-tool --port ' .. serial_port .. ' remove init.lua',
      reset,
      'nodemcu-tool --port ' .. serial_port .. ' remove init.lc'
    }

    if data ~= '' then
      table.insert(commands, reset)
      table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --keeppath ' .. data)
    end

    if source ~= '' then
      table.insert(commands, reset)
      table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --compile ' .. source)
    end

    table.insert(commands, reset)
    table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload ' .. init_lua)

    exec(commands)
  end
}
