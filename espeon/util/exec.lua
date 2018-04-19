return function(commands)
  if type(commands) == 'string' then
    commands = { commands }
  end

  for _, command in ipairs(commands) do
    print(command)
    if not os.execute(command) then
      os.exit(1)
    end
    print()
  end
end
