local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Format the filesystem of a connected ESP running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()

    print('Formatting filesystem...')
    exec('nodemcu-tool --port ' .. serial_port .. ' reset && sleep 1.5')
    exec('nodemcu-tool --port ' .. serial_port .. ' mkfs')
    print()
  end
}
