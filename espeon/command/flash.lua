local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'

return {
  description = 'Flash the firmware specified in ./espeon_config.lua to a connected ESP8266',

  execute =  function(platform, serial_port)
    local config = load_config()
    local source = table.concat(config.source, ' ')
    local data = table.concat(config.data, ' ')

    local commands = {}
    if data ~= '' then
      table.insert(commands, 'nodemcu-uploader --port ' .. serial_port .. ' upload ' .. data)
    end
    if source ~= '' then
      table.insert(commands, 'nodemcu-uploader --port ' .. serial_port .. ' upload ' .. source .. ' --compile')
    end
    exec(commands)
  end
}
