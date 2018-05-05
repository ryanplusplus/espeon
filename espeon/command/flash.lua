local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Flash the firmware specified in ./espeon.conf to a connected ESP8266',

  execute = function()
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local commands = {
      'nodemcu-uploader --port ' .. serial_port .. ' file remove init.lua',
      'nodemcu-uploader --port ' .. serial_port .. ' file remove init.lc',
      'nodemcu-uploader --port ' .. serial_port .. ' node restart'
    }
    if data ~= '' then
      table.insert(commands, 'nodemcu-uploader --port ' .. serial_port .. ' upload ' .. data)
    end
    if source ~= '' then
      table.insert(commands, 'nodemcu-uploader --port ' .. serial_port .. ' upload ' .. source .. ' --compile')
    end
    exec(commands)
  end
}
