local shell = require 'espeon.util.shell'

return function(sources)
  local output_bundle = os.tmpname()

  local modules = {}
  for _, source in ipairs(sources) do
    if source ~= 'init.lua' then
      module = source:gsub('%.lua$', '')
      table.insert(modules, module)
    end
  end
  modules = table.concat(modules, ' ')

  shell('amalg.lua -o ' .. output_bundle .. ' -s init.lua ' .. modules)

  return output_bundle
end
