local exec = require 'espeon.util.exec'

return {
  description = 'Resets a connected ESP8266 running NodeMCU',

  execute = function(platform, serial_port)
    exec('nodemcu-uploader --port ' .. serial_port .. ' node restart')
  end
}
