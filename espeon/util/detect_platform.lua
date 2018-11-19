local shell = require 'espeon.util.shell'

return function()
  local uname = shell('uname', true)
  if uname:match('Darwin') then
    return 'mac'
  elseif uname:match('Linux') then
    return 'linux'
  else
    return 'windows'
  end
end
