local datafile = require 'datafile'
local exec = require 'espeon.util.exec'

local espeon_config_lua = datafile.path('res/espeon_config.lua')

return {
  description = 'Write a default espeon_config.lua to .',

  execute =  function(platform, serial_port)
    exec('cp ' .. espeon_config_lua .. ' .')
  end
}
