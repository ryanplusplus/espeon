local exec = require 'espeon.util.exec'
local shell = require 'espeon.util.shell'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Show filesystem information for a connected ESP running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()
    exec('nodemcu-tool --port ' .. serial_port .. ' reset && sleep 1.5')
    print(shell('nodemcu-tool --port ' .. serial_port .. ' fsinfo'))
  end
}
