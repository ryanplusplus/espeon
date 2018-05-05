local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Format the filesystem of a connected ESP8266 running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()
    exec('nodemcu-uploader --port ' .. serial_port .. ' file format')
  end
}
