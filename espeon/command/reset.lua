local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Resets a connected ESP running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()

    print('Resetting...')
    exec('nodemcu-tool --port ' .. serial_port .. ' reset')
    print()
  end
}
