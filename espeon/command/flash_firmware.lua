local datafile = require 'datafile'
local load_config = require 'espeon.util.load_config'
local device_info = require 'espeon.util.device_info'
local exec = require 'espeon.util.exec'

local esp_init_data_default_bin = datafile.path('res/esp_init_data_default.bin')
local blank_bin = datafile.path('res/blank.bin')

return {
  description = 'Flash the firmware specified in ./espeon_config.lua to a connected ESP8266',

  execute =  function(platform, serial_port)
    local config = load_config()
    local device_info = device_info(config.device)

    exec({
      'esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash -fm dio -fs ' .. device_info.flash_size .. ' 0x3fc000 ' .. esp_init_data_default_bin .. ' 0x7e000 ' .. blank_bin,
      'esptool.py --baud 115200 --port ' .. serial_port .. ' write_flash -fm dio -fs ' .. device_info.flash_size .. ' 0x00000 ' .. config.firmware
    })

    print('After flashing firmware, the filesystem may need to be formatted. This can take a while. Please be patient.')
    print()
  end
}
