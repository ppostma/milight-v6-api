# frozen_string_literal: true

module Milight
  module V6
    class Zone
      attr_reader :zone_id

      def initialize(command, zone_id)
        @command = command
        @zone_id = zone_id
      end

      # Link/sync light bulbs.
      def link
        @command.link(zone_id)

        self
      end

      # Unlink/clear light bulbs.
      def unlink
        @command.unlink(zone_id)

        self
      end

      # Switch the lights on.
      def on
        @command.on(zone_id)

        self
      end

      # Switch the lights off.
      def off
        @command.off(zone_id)

        self
      end

      # Enable night light mode.
      def night_light
        @command.night_light(zone_id)

        self
      end

      # Set brightness, value: 0% to 100%
      def brightness(value)
        @command.brightness(zone_id, value)

        self
      end

      # Set color temperature, value: 0 = 2700K, 100 = 6500K.
      def temperature(value)
        @command.temperature(zone_id, value)

        self
      end

      # Set color temperature to warm light (2700K).
      def warm_light
        @command.temperature(zone_id, 0)

        self
      end

      # Set color temperature to white (cool) light (6500K).
      def white_light
        @command.temperature(zone_id, 100)

        self
      end

      # Set the hue, value: 0 to 255 (red).
      # See Milight::V6::Color for predefined colors.
      def hue(value)
        @command.hue(zone_id, value)

        self
      end

      # Set the saturation, value: 0% to 100%.
      def saturation(value)
        @command.saturation(zone_id, value)

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
