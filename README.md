# Milight Wifi Bridge v6 Ruby API

This gem provides a Ruby API for the Milight Wifi Bridge (or Wifi iBOX controller) version 6.

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

controller.zone(2).on.brightness(70).warm_light

controller.zone(3).on.saturation(80).hue(Milight::V6::Color::BLUE)

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
