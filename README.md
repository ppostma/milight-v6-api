# Milight Wifi Bridge v6 Ruby API

[![Gem Version](https://badge.fury.io/rb/milight-v6.svg)](https://badge.fury.io/rb/milight-v6)
[![Build Status](https://travis-ci.org/ppostma/milight-v6-api.svg?branch=master)](https://travis-ci.org/ppostma/milight-v6-api)
[![Code Climate](https://codeclimate.com/github/ppostma/milight-v6-api/badges/gpa.svg)](https://codeclimate.com/github/ppostma/milight-v6-api)

This gem provides a Ruby API for the Mi-Light Wifi Bridge using protocol version 6.

Supported devices are the Mi-Light WiFi iBox models 1 and 2. The [esp8266_milight_hub](https://github.com/sidoh/esp8266_milight_hub) should also work, but I haven't tested this yet.
The bridges sold under the brand MiBoxer (such as model WL-Box1) are not supported by this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'milight-v6'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install milight-v6

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

Usage: milight &lt;host&gt; &lt;command&gt; [zone]

Supported commands: on, off, link, unlink

```bash
$ milight 192.168.178.33 on 1  # turn on lights for zone 1
$ milight 192.168.178.33 off   # turn off lights for all zones
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ppostma/milight-v6-api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
