local datafile = require 'datafile'
local exec = require 'espeon.util.exec'
local shell = require 'espeon.util.shell'

local espeon_conf = datafile.path('res/espeon.conf')

return {
  description = 'Write a default espeon.conf to .',

  execute = function()
    exec('cp ' .. espeon_conf .. ' .')
    print('Default espeon.conf written to ' .. shell('pwd'))
  end
}
