# frozen_string_literal: true

require "logger"
require "socket"

module Milight
  module V6
    class Socket
      def initialize(host, port)
        @host = host
        @port = port
        @socket = UDPSocket.new

        @logger = Logger.new(STDOUT)
        @logger.level = Logger::INFO if ENV["MILIGHT_DEBUG"] != "1"
      end

      def send_bytes(bytes)
        @logger.debug("Sending: #{format_bytes_as_hex(bytes)}")

        @socket.send bytes.pack('C*'), 0, @host, @port
      end

      def receive_bytes
        response = @socket.recvfrom(128).first
        bytes = response.unpack('C*')

        @logger.debug("Received: #{format_bytes_as_hex(bytes)}")

        bytes
      end

      private

      def format_bytes_as_hex(bytes)
        bytes.map { |s| format("0x%02X", s) }
      end
    end
  end
end
