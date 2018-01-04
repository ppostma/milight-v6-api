# frozen_string_literal: true

require "milight/v6/command"
require "milight/v6/all"
require "milight/v6/zone"

module Milight
  module V6
    class Controller
      def initialize(host, port = 5987)
        @command = Milight::V6::Command.new(host, port)
      end

      # Select all zones.
      def all
        Milight::V6::All.new(@command)
      end

      # Select a specific zone.
      def zone(zone_id)
        Milight::V6::Zone.new(@command, zone_id)
      end
    end
  end
end
