local datafile = require 'datafile'
local exec = require 'espeon.util.exec'
local load_config = require 'espeon.util.load_config'
local detect_serial_port = require 'espeon.util.detect_serial_port'
local shell = require 'espeon.util.shell'
local compile = require 'espeon.util.compile'

local init_lua = datafile.path('res/init.lua')

return {
  description = 'Upload the source and data specified in ./espeon.conf',

  execute = function(arg)
    local config = load_config()
    local serial_port = detect_serial_port()
    local source = table.concat(config.source or {}, ' ')
    local data = table.concat(config.data or {}, ' ')

    local reset = 'nodemcu-tool --port ' .. serial_port .. ' reset && sleep 1.4'

    local commands = {
      reset,
      'nodemcu-tool --port ' .. serial_port .. ' remove init.lua'
    }

    if data ~= '' then
      table.insert(commands, reset)
      table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --keeppath ' .. data)
    end

    if source ~= '' then
      local expanded_source = shell('echo ' .. source)

      local sources = {}
      for source in expanded_source:gmatch('%S+') do
        table.insert(sources, source)
      end

      local bin = compile(sources, config.target)

      table.insert(commands, reset)
      table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload --remotename app.lc ' .. bin)
    end

    table.insert(commands, reset)
    table.insert(commands, 'nodemcu-tool --port ' .. serial_port .. ' upload ' .. init_lua)

    exec(commands)
  end
}
