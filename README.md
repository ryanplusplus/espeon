# espeon
Tool for working with ESP8266/ESP32 + NodeMCU projects

## Installation

```shell
luarocks install espeon
espeon install_dependencies
```

## Usage

```shell
espeon <command> [arguments]
```

### Available Commands
  - `console` - Open a console to a connected ESP running NodeMCU
  - `erase` - Erase the flash of a connected ESP
  - `flash` - Flash the firmware specified in `./espeon.conf` to a connected ESP
  - `format` - Format the filesystem of a connected ESP running NodeMCU
  - `fs` - Show filesystem information for a connected ESP running NodeMCU
  - `init` - Write a default `espeon.conf` to `.`
  - `install_dependencies` - Install all external dependencies
  - `reset` - Resets a connected ESP running NodeMCU
  - `upload` - Upload the source and data specified in ./espeon.conf if no arguments are provided; upload the specified file if an argument is provided
