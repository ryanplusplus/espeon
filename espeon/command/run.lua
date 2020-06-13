local upload = require 'espeon.command.upload'
local reset = require 'espeon.command.reset'
local console = require 'espeon.command.console'

return {
  description = 'Uploads application, resets, and opens a console',

  execute = function()
    upload.execute()
    reset.execute()
    console.execute()
  end
}
