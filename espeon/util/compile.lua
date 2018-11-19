local shell = require 'espeon.util.shell'
local detect_platform = require 'espeon.util.detect_platform'
local datafile = require 'datafile'

return function(source, target)
  local platform = detect_platform()
  local luac = datafile.path('res/luac.cross-' .. platform)
  local output_bin = os.tmpname()

  shell(luac .. ' -o ' .. output_bin .. ' ' .. source)

  return output_bin
end
