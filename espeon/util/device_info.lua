local devices = {
  ['wemos d1 mini lite'] = { flash_size = '1MB' },
  ['wemos d1 mini'] = { flash_size = '4MB' },
  ['wemos d1 mini pro'] = { flash_size = '16MB' },
  ['nodemcu devkit v1'] = { flash_size = '1MB' },
  ['nodemcu devkit v2'] = { flash_size = '4MB' },
  ['nodemcu devkit v3'] = { flash_size = '4MB' }
}

return function(device)
  if not devices[device] then
    print("Unrecognized device '" .. device .. '"')
    print()
    print('Supported devices:')

    local device_names = {}
    for device_name in pairs(devices) do
      table.insert(device_names, "  - '" .. device_name .. "'")
    end
    table.sort(device_names)
    print(table.concat(device_names, '\n'))
    print()

    os.exit(1)
  end

  return devices[device]
end
