local exec = require 'espeon.util.exec'
local detect_platform = require 'espeon.util.detect_platform'

local nodemcu_tool = 'nodemcu-tool@3.2.1'

return {
  description = 'Install all external dependencies',

  execute = function()
    local platform = detect_platform()

    if platform == 'linux' then
      exec({
        'sudo apt-get install screen',
        'sudo apt-get install python-pip || sudo apt-get install python3-pip',
        'sudo -H pip install esptool --upgrade || sudo -H pip3 install esptool --upgrade',
        'which npm > /dev/null || sudo apt install nodejs',
        'npm install -g ' .. nodemcu_tool .. ' || sudo npm install -g ' .. nodemcu_tool
      })
    elseif platform == 'mac' then
      exec({
        'sudo easy_install pip',
        'sudo pip install esptool --upgrade',
        'which brew > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"',
        'which npm > /dev/null || brew install node',
        'npm install -g ' .. nodemcu_tool .. ' || sudo npm install -g ' .. nodemcu_tool
      })
    end
  end
}
