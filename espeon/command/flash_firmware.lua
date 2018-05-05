local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'
local exec = require 'espeon.util.exec'

return {
  description = 'Flash the firmware specified in ./espeon.conf to a connected ESP8266',

  execute = function()
    local serial_port = detect_serial_port()
    local config = load_config()
    exec('esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash 0x0 ' .. config.firmware)
    print('After flashing firmware, the filesystem may need to be formatted. This can take a while. Please be patient.')
    print()
  end
}
