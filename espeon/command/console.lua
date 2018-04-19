local exec = require 'espeon.util.exec'

return {
  description = 'Open a console to a connected ESP8266 running NodeMCU',

  execute = function(platform, serial_port)
    exec('screen ' .. serial_port .. ' 115200')
  end
}
