# frozen_string_literal: true

module Milight
  module V6
    # Commands for the bridge lamp (iBox model 1).
    class Bridge
      def initialize(command)
        @command = command
      end

      # Switch the light on.
      def on
        @command.execute(1, [0x31, 0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00])

        self
      end

      # Switch the light off.
      def off
        @command.execute(1, [0x31, 0x00, 0x00, 0x00, 0x03, 0x04, 0x00, 0x00, 0x00])

        self
      end

      # Set brightness, value: 0% to 100%.
      def brightness(value)
        raise ArgumentError, "Please supply a brightness value between 0-100." if value.negative? || value > 100

        @command.execute(1, [0x31, 0x00, 0x00, 0x00, 0x02, value, 0x00, 0x00, 0x00])

        self
      end

      # Set color to white light.
      def white_light
        @command.execute(1, [0x31, 0x00, 0x00, 0x00, 0x03, 0x05, 0x00, 0x00, 0x00])

        self
      end

      # Set the hue, value: 0 to 255 (red).
      # See Milight::V6::Color for predefined colors.
      def hue(value)
        raise ArgumentError, "Please supply a hue value between 0-255." if value.negative? || value > 255

        @command.execute(1, [0x31, 0x00, 0x00, 0x00, 0x01, value, value, value, value])

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
