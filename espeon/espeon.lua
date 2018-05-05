return function()
  local command = table.concat(arg, '_')

  local commands = {
    console = require 'espeon.command.console',
    erase = require 'espeon.command.erase',
    flash = require 'espeon.command.flash',
    flash_firmware = require 'espeon.command.flash_firmware',
    format = require 'espeon.command.format',
    init = require 'espeon.command.init',
    install_dependencies = require 'espeon.command.install_dependencies',
    reset = require 'espeon.command.reset'
  }

  if commands[command] then
    commands[command].execute()
  else
    print('espeon')
    print('Usage: espeon <command>')
    print()
    print('Available commands:')

    local command_descriptions = {}
    for name, command in pairs(commands) do
      table.insert(command_descriptions, '  ' .. name .. ' - ' .. command.description)
    end
    table.sort(command_descriptions)
    print(table.concat(command_descriptions, '\n'))
  end
end
