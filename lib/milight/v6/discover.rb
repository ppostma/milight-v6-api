# frozen_string_literal: true

require "milight/v6/controller"
require "milight/v6/socket"

module Milight
  module V6
    # Search for Mi-Light devices.
    module Discover
      AUTH_TOKEN = [0x39, 0x38, 0x35, 0x62, 0x31, 0x35, 0x37, 0x62, 0x66, 0x36, 0x66,
                    0x63, 0x34, 0x33, 0x33, 0x36, 0x38, 0x61, 0x36, 0x33, 0x34, 0x36,
                    0x37, 0x65, 0x61, 0x33, 0x62, 0x31, 0x39, 0x64, 0x30, 0x64].freeze

      def search
        socket = Milight::V6::Socket.new("<broadcast>", 5987)

        bytes =  [0x10, 0x00, 0x00, 0x00, 0x24, 0x02, 0xEE, 0x3E, 0x02] + AUTH_TOKEN
        socket.send_bytes(bytes)

        controllers = []

        loop do
          bytes, address = socket.receive_bytes
          break if bytes.nil?

          token = bytes[14, AUTH_TOKEN.length]
          controllers << Milight::V6::Controller.new(address) if token == AUTH_TOKEN
        end

        socket.close

        controllers
      end
    end
  end
end
