# frozen_string_literal: true

require "milight/v6/command"
require "milight/v6/discover"
require "milight/v6/all"
require "milight/v6/bridge"
require "milight/v6/zone"

module Milight
  module V6
    # Controller for the Mi-Light WiFi iBox.
    class Controller
      extend Milight::V6::Discover

      def initialize(host = "<broadcast>", port = 5987, wait: 0.1)
        @socket = Milight::V6::Socket.new(host, port)
        @command = Milight::V6::Command.new(@socket, wait: wait)
      end

      # Select all zones.
      def all
        Milight::V6::All.new(@command)
      end

      # Select a specific zone.
      def zone(zone_id)
        Milight::V6::Zone.new(@command, zone_id)
      end

      # Select the bridge lamp.
      def bridge
        Milight::V6::Bridge.new(@command)
      end

      def to_s
        "Mi-Light Wifi iBox Controller. IP address: #{@socket.host}"
      end
    end
  end
end
