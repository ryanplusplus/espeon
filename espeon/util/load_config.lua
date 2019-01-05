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

  assert(config.target, "espeon.conf missing required field 'target'")
  assert(config.firmware, "espeon.conf missing required field 'firmware'")
  assert(config.source, "espeon.conf missing required field 'source'")

  for _, field in ipairs({ 'target', 'firmware', 'source' }) do
    assert(config[field], "espeon.conf missing required field '" .. field .. "'")
  end

  assert(config.target == 'ESP8266' or config.target == 'ESP32', "The target specified in espeon.conf must match 'ESP8266' or 'ESP32'")

  if config.lfs then
    assert(config.target == 'ESP8266', 'LFS is only supported for ESP8266 targets')
  end

  return config
end
