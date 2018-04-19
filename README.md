# espeon
Tool for working with ESP8266 + NodeMCU projects

## Installation

```shell
luarocks install espeon
```

## Usage

```shell
espeon <command>
```

### Available Commands
  - `bootstrap` - Install all external dependencies
  - `console` - Open a console to a connected ESP8266 running NodeMCU
  - `erase` - Erase the flash of a connected ESP8266
  - `flash` - Flash the firmware specified in `./espeon_config.lua` to a connected ESP8266
  - `flash_firmware` - Flash the firmware specified in `./espeon_config.lua` to a connected ESP8266
  - `format` - Format the filesystem of a connected ESP8266 running NodeMCU
  - `init` - Write a default `espeon_config.lua` to `.`
  - `reset` - Resets a connected ESP8266 running NodeMCU
