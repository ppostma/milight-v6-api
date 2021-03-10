# frozen_string_literal: true

module Milight
  module V6
    # Commands for lamps in all zones.
    class All
      def initialize(command)
        @command = command
      end

      # Switch the lights on.
      def on
        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x04, 0x01, 0x00, 0x00, 0x00])

        self
      end

      # Switch the lights off.
      def off
        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x04, 0x02, 0x00, 0x00, 0x00])

        self
      end

      # Enable night light mode.
      def night_light
        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x04, 0x05, 0x00, 0x00, 0x00])

        self
      end

      # Set brightness, value: 0% to 100%.
      def brightness(value)
        raise ArgumentError, "Please supply a brightness value between 0-100." if value.negative? || value > 100

        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x03, value, 0x00, 0x00, 0x00])

        self
      end

      # Set color temperature, value: 0 = 2700K, 100 = 6500K.
      def temperature(value)
        raise ArgumentError, "Please supply a temperature value between 0-100 (2700K to 6500K)." if value.negative? || value > 100

        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x05, value, 0x00, 0x00, 0x00])

        self
      end

      # Set color temperature to warm light (2700K).
      def warm_light
        temperature(0)
      end

      # Set color temperature to white (cool) light (6500K).
      def white_light
        temperature(100)
      end

      # Set the hue, value: 0 to 255 (red).
      # See Milight::V6::Color for predefined colors.
      def hue(value)
        raise ArgumentError, "Please supply a hue value between 0-255." if value.negative? || value > 255

        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x01, value, value, value, value])

        self
      end

      # Set the saturation, value: 0% to 100%.
      def saturation(value)
        raise ArgumentError, "Please supply a saturation value between 0-100." if value.negative? || value > 100

        @command.execute(0, [0x31, 0x00, 0x00, 0x08, 0x02, value, 0x00, 0x00, 0x00])

        self
      end

      # Wait before continuing to next command.
      def wait(seconds)
        sleep(seconds)

        self
      end
    end
  end
end
