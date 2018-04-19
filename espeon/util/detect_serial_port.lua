local shell = require 'espeon.util.shell'

return function()
  if os.getenv('SERIAL_PORT') then
    return os.getenv('SERIAL_PORT')
  else
    local device_name = shell('ls /dev/ | grep -i tty | grep -m1 -i usb')
    return '/dev/' .. device_name:gsub('\n', '')
  end
end
