local shell = require 'espeon.util.shell'
local detect_platform = require 'espeon.util.detect_platform'
local datafile = require 'datafile'

return function(sources, target)
  local platform = detect_platform()
  local luac = datafile.path('res/luac.cross-' .. platform)
  local output_bundle = os.tmpname()
  local output_bin = os.tmpname()

  local modules = {}
  for _, source in ipairs(sources) do
    if source ~= 'init.lua' then
      module = source:gsub('%.lua$', '')
      table.insert(modules, module)
    end
  end
  modules = table.concat(modules, ' ')

  shell('amalg.lua -o ' .. output_bundle .. ' -s init.lua ' .. modules)
  shell(luac .. ' -o ' .. output_bin .. ' ' .. output_bundle)

  return output_bin
end
