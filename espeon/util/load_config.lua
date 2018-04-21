local read_file = require 'espeon.util.read_file'

return function()
  local ok, config = pcall(function()
    local config = read_file('espeon.conf')
    return (loadstring or load)('return ' .. config)()
  end)

  if not ok then
    print('Unable to load espeon.conf:')
    print(config)
    os.exit(1)
  end

  return config
end
