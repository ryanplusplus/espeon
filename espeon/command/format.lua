local exec = require 'espeon.util.exec'

return {
  description = 'Format the filesystem of a connected ESP8266 running NodeMCU',

  execute = function(platform, serial_port)
    exec('nodemcu-uploader --port ' .. serial_port .. ' file format')
  end
}
