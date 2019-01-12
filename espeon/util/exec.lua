local shell = require 'espeon.util.shell'

return function(commands)
  if type(commands) == 'string' then
    commands = { commands }
  end

  for _, command in ipairs(commands) do
    shell(command)
  end
end
