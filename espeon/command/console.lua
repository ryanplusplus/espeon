local exec = require 'espeon.util.exec'
local detect_serial_port = require 'espeon.util.detect_serial_port'

return {
  description = 'Open a console to a connected ESP running NodeMCU',

  execute = function()
    local serial_port = detect_serial_port()
    exec('screen ' .. serial_port .. ' 115200')
  end
}
