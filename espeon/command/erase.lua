local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Erase the flash of a connected ESP',

  execute = function()
    local serial_port = detect_serial_port()
    print('Erasing flash...')
    exec('esptool.py --baud 115200 --port ' .. serial_port .. ' erase_flash')
    print()
  end
}
