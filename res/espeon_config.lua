{
  --[[
    Specifies the device that application and firmware will
    be flashed onto so that the tool knows how much flash
    is available, etc.

    Supported devices:
    - 'wemos d1 mini lite'
    - 'wemos d1 mini'
    - 'wemos d1 mini pro'
    - 'nodemcu devkit v1'
    - 'nodemcu devkit v2'
    - 'nodemcu devkit v3'

    If unsure, select 'nodemcu devkit v2'
  ]]
  device = 'nodemcu devkit v2',

  -- Path to the firmware for the application
  firmware = 'fw.bin',

  -- Paths to all Lua files to flash
  source = {
    'src/*'
  },

  -- Paths to all data files to flash
  data = {
    'data/*'
  }
}
