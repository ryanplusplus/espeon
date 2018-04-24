local exec = require 'espeon.util.exec'

return {
  description = 'Install all external dependencies',

  execute = function(platform, serial_port)
    if platform == 'linux' then
      exec({
        'sudo apt install screen',
        'sudo apt install python-pip',
        'sudo pip install esptool --upgrade',
        'sudo pip install nodemcu-uploader --upgrade'
      })
    elseif platform == 'mac' then
      exec({
        'sudo easy_install pip',
        'sudo pip install esptool --upgrade',
        'sudo pip install nodemcu-uploader --upgrade',
        'curl "http://www.wch.cn/downfile/178" -o "usb-to-uart-driver.zip"',
        'unzip usb-to-uart-driver.zip',
        'rm usb-to-uart-driver.zip',
        'sudo installer -store -pkg "CH341SER_MAC/CH34x_Install_V1.4.pkg" -target',
        'rm CH341SER_MAC/CH34x_Install_V1.4.pkg'
      })
    end
  end
}
