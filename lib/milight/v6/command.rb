# frozen_string_literal: true

require "milight/v6/exception"
require "milight/v6/socket"

module Milight
  module V6
    # see https://github.com/Fantasmos/LimitlessLED-DevAPI
    class Command
      def initialize(host, port = 5987)
        @socket = Milight::V6::Socket.new(host, port)

        bridge_session
      end

      def link(zone_id)
        execute(zone_id, [0x3D, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00])
      end

      def unlink(zone_id)
        execute(zone_id, [0x3E, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00])
      end

      def on(zone_id)
        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x04, 0x01, 0x00, 0x00, 0x00])
      end

      def off(zone_id)
        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x04, 0x02, 0x00, 0x00, 0x00])
      end

      def night_light(zone_id)
        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x04, 0x05, 0x00, 0x00, 0x00])
      end

      def brightness(zone_id, value)
        raise ArgumentError, "Please supply a brightness value between 0-100." if value.negative? || value > 100

        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x03, value, 0x00, 0x00, 0x00])
      end

      def temperature(zone_id, value)
        raise ArgumentError, "Please supply a temperature value between 0-100 (2700K to 6500K)." if value.negative? || value > 100

        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x05, value, 0x00, 0x00, 0x00])
      end

      def hue(zone_id, value)
        raise ArgumentError, "Please supply a hue value between 0-255." if value.negative? || value > 255

        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x01, value, value, value, value])
      end

      def saturation(zone_id, value)
        raise ArgumentError, "Please supply a saturation value between 0-100." if value.negative? || value > 100

        execute(zone_id, [0x31, 0x00, 0x00, 0x08, 0x02, value, 0x00, 0x00, 0x00])
      end

      def execute(zone_id, command)
        raise ArgumentError, "Please supply a zone ID between 1-4." if zone_id.negative? || zone_id > 4

        # UDP Hex Send Format: 80 00 00 00 11 {WifiBridgeSessionID1} {WifiBridgeSessionID2} 00 {SequenceNumber} 00 {COMMAND} {ZONE NUMBER} 00 {Checksum}
        request = [0x80, 0x00, 0x00, 0x00, 0x11, @session_id1, @session_id2, 0x00, next_sequence_number, 0x00]

        request += command

        request << zone_id
        request << 0x00
        request << calculate_checksum(request)

        @socket.send_bytes(request)
        @socket.receive_bytes
      end

      private

      def bridge_session
        # UDP.SEND hex bytes: 20 00 00 00 16 02 62 3A D5 ED A3 01 AE 08 2D 46 61 41 A7 F6 DC AF (D3 E6) 00 00 1E <-- Send this to the ip address of the wifi bridge v6
        request = [0x20, 0x00, 0x00, 0x00, 0x16, 0x02, 0x62, 0x3A, 0xD5,
                   0xED, 0xA3, 0x01, 0xAE, 0x08, 0x2D, 0x46, 0x61, 0x41,
                   0xA7, 0xF6, 0xDC, 0xAF, 0xD3, 0xE6, 0x00, 0x00, 0x1E]

        @socket.send_bytes(request)
        response = @socket.receive_bytes

        raise Exception, "Could not establish session with Wifi bridge." unless response

        @session_id1 = response[19]
        @session_id2 = response[20]
      end

      def next_sequence_number
        @sequence_number = 0 if @sequence_number.nil? || @sequence_number >= 255
        @sequence_number += 1

        @sequence_number
      end

      def calculate_checksum(bytes)
        checksum = 0

        for i in 10..19 do
          checksum += bytes[i]
        end

        checksum & 0xFF
      end
    end
  end
end
