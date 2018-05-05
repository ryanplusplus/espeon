local datafile = require 'datafile'
local exec = require 'espeon.util.exec'

local espeon_conf = datafile.path('res/espeon.conf')

return {
  description = 'Write a default espeon.conf to .',

  execute = function()
    exec('cp ' .. espeon_conf .. ' .')
  end
}
