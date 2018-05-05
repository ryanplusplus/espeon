local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Resets a connected ESP8266 running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()
    exec('nodemcu-uploader --port ' .. serial_port .. ' node restart')
  end
}
