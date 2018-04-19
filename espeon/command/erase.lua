local exec = require 'espeon.util.exec'

return {
  description = 'Erase the flash of a connected ESP8266',

  execute = function(platform, serial_port)
    exec('esptool.py --baud 115200 --port ' .. serial_port .. ' erase_flash')
  end
}
