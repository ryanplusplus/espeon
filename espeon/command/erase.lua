local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Erase the flash of a connected ESP8266',

  execute = function()
    local serial_port = require detect_serial_port()
    exec('esptool.py --baud 115200 --port ' .. serial_port .. ' erase_flash')
  end
}
