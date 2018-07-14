local exec = require 'espeon.util.exec'
local detect_platform = require 'espeon.util.detect_platform'

return {
  description = 'Install all external dependencies',

  execute = function()
    local platform = detect_platform()

    if platform == 'linux' then
      exec({
        'sudo apt install screen',
        'sudo apt install python-pip',
        'sudo pip install esptool --upgrade',
        'which npm > /dev/null || sudo apt install nodejs',
        'npm install -g nodemcu-tool || sudo npm install -g nodemcu-tool'
      })
    elseif platform == 'mac' then
      exec({
        'sudo easy_install pip',
        'sudo pip install esptool --upgrade',
        'which brew > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"',
        'which npm > /dev/null || brew install node',
        'npm install -g nodemcu-tool || sudo npm install -g nodemcu-tool'
      })
    end
  end
}
