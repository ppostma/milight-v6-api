# Milight Wifi Bridge v6 Ruby API

[![Gem Version](https://badge.fury.io/rb/milight-v6.svg)](https://badge.fury.io/rb/milight-v6)
[![Build Status](https://travis-ci.org/ppostma/milight-v6-api.svg?branch=master)](https://travis-ci.org/ppostma/milight-v6-api)
[![Code Climate](https://codeclimate.com/github/ppostma/milight-v6-api/badges/gpa.svg)](https://codeclimate.com/github/ppostma/milight-v6-api)

This gem provides a Ruby API for the Milight Wifi Bridge (or Wifi iBOX controller) version 6.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'milight-v6'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install milight-v6
```

## Usage

```ruby
require "milight/v6"

controller = Milight::V6::Controller.new("192.168.178.33")
controller.zone(1).on

controller.zone(2).warm_light.brightness(70).on

controller.zone(3).hue(Milight::V6::Color::BLUE).saturation(10).on

controller.all.off
```

See `Milight::V6::All` and `Milight::V6::Zone` for all supported commands.

## Command line

A command line tool is included which can be used to control the lights.

Example usage:

```bash
milight --host 192.168.1.66 --all --brightness=30 --color=RED
```

Display the usage instructions with:

```bash
milight --help
```

```bash
Usage: milight [options]
    -x, --host HOST                  ip address of milight
    -p, --port PORT                  port number. defaults to 5987
    -a, --all                        all zones
    -z, --zone ZONE                  specific zone. 1-4
    -g, --zones ZONES                group of zones. 1-4,1-4...
    -l, --link                       link/sync light bulbs
    -u, --unlink                     unlink/clear light bulbs
    -o, --on                         turn on
    -i, --off                        turn off
    -b, --brightness BRIGHTNESS      set brightness. 0 = 0%, 100 = 100%
    -t, --temperature TEMPERATURE    set temperature. 0 = 2700K, 100 = 6500K
    -m, --warm                       set warm light. 2700K
    -w, --white                      set white light. 6500K
    -n, --night                      set night light
    -e, --hue HUE                    set hue. 0 to 255 (red)
    -c, --color COLOR                set color. ["RED", "LAVENDER", "BLUE", "AQUA", "GREEN", "LIME", "YELLOW", "ORANGE"]
    -s, --saturation SATURATION      set saturation. 0 = 0%, 100 = 100%
    -v, --version                    display the version number
    -r, --refresh                    use if the lights get stuck
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/ppostma/milight-v6-api).

To test your changes to the command line tool:

```bash
gem build milight-v6.gemspec
gem install ./milight-v6-0.2.0.gem
milight <OPTIONS>
```

## Troubleshooting

`Could not establish session with Wifi bridge. (Milight::V6::Exception)`

When this message appears, either:

1. the host address is wrong
2. your computer is not on the same network as the milight
3. you just need to wait some time and try again later 🤷

The host address can be found on you router's homepage. If you're using macOS or linux, you may be able to run `arp -a` to see a list of devices on your network. The host address should look something like:

```bash
hf-lpb100.lan (192.168.1.66) at ... on en0 ifscope [ethernet]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
