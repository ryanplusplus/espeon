local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'
local exec = require 'espeon.util.exec'

return {
  description = 'Flash the firmware specified in ./espeon.conf to a connected ESP',

  execute = function()
    local serial_port = detect_serial_port()
    local config = load_config()

    print('Flashing firmware...')

    if type(config.firmware) == 'table' then
      for bin, offset in pairs(config.firmware) do
        exec('esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash ' .. offset .. ' ' .. bin)
      end
    else
      local offset = (config.target == 'ESP32') and '0x10000' or '0x0'
      exec('esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash ' .. offset .. ' ' .. config.firmware)
    end

    print('After flashing firmware, the filesystem may need to be formatted. This can take a while. Please be patient.')
    print()
  end
}
