# espeon
Tool for working with ESP8266 + NodeMCU projects

## Installation

```shell
luarocks install espeon
espeon install_dependencies
```

## Usage

```shell
espeon <command>
```

### Available Commands
  - `console` - Open a console to a connected ESP8266 running NodeMCU
  - `erase` - Erase the flash of a connected ESP8266
  - `flash` - Flash the firmware specified in `./espeon.conf` to a connected ESP8266
  - `flash_firmware` - Flash the firmware specified in `./espeon.conf` to a connected ESP8266
  - `format` - Format the filesystem of a connected ESP8266 running NodeMCU
  - `init` - Write a default `espeon.conf` to `.`
  - `install_dependencies` - Install all external dependencies
  - `reset` - Resets a connected ESP8266 running NodeMCU
