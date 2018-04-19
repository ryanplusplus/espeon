local read_file = require 'espeon.util.read_file'

return function()
  local ok, config = pcall(function()
    local config = read_file('espeon_config.lua')
    return (loadstring or load)('return ' .. config)()
  end)

  if not ok then
    print('Unable to load espeon_config.lua:')
    print(config)
    os.exit(1)
  end

  return config
end
