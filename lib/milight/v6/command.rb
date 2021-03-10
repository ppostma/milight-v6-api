# frozen_string_literal: true

require "milight/v6/exception"
require "milight/v6/socket"

module Milight
  module V6
    # see https://github.com/Fantasmos/LimitlessLED-DevAPI
    class Command
      def initialize(socket)
        @socket = socket
      end

      def execute(zone_id, command)
        raise ArgumentError, "Please supply a zone ID between 1-4." if zone_id.negative? || zone_id > 4

        bridge_session

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
        return if !@session_id1.nil? || !@session_id2.nil?

        # UDP.SEND hex bytes: 20 00 00 00 16 02 62 3A D5 ED A3 01 AE 08 2D 46 61 41 A7 F6 DC AF (D3 E6) 00 00 1E <-- Send this to the ip address of the wifi bridge v6
        request = [0x20, 0x00, 0x00, 0x00, 0x16, 0x02, 0x62, 0x3A, 0xD5,
                   0xED, 0xA3, 0x01, 0xAE, 0x08, 0x2D, 0x46, 0x61, 0x41,
                   0xA7, 0xF6, 0xDC, 0xAF, 0xD3, 0xE6, 0x00, 0x00, 0x1E]

        @socket.send_bytes(request)
        response, _address = @socket.receive_bytes

        raise Exception, "Could not establish session with Wifi bridge." if response.nil?

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
