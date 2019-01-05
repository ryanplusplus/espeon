local shell = require 'espeon.util.shell'
local detect_platform = require 'espeon.util.detect_platform'
local datafile = require 'datafile'

return function(sources, base_address)
  local platform = detect_platform()
  local luac = datafile.path('res/luac.cross-' .. platform)
  local output_bin = os.tmpname()

  shell(luac .. ' -a ' .. base_address .. ' -o ' .. output_bin .. ' -f ' .. table.concat(sources, ' '))

  return output_bin
end
