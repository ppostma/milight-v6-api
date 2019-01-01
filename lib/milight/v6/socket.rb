# frozen_string_literal: true

require "logger"
require "socket"

module Milight
  module V6
    class Socket
      READ_TIMEOUT = 5

      def initialize(host, port)
        @socket = UDPSocket.new
        @socket.connect(host, port)

        @logger = Logger.new(STDOUT)
        @logger.level = Logger::INFO if ENV["MILIGHT_DEBUG"] != "1"
      end

      def send_bytes(bytes)
        @logger.debug("Sending: #{format_bytes_as_hex(bytes)}")

        @socket.send(bytes.pack('C*'), 0)
      end

      def receive_bytes
        response = @socket.recvfrom_nonblock(128).first
        bytes = response.unpack('C*')

        @logger.debug("Received: #{format_bytes_as_hex(bytes)}")

        bytes
      rescue IO::WaitReadable
        ready = IO.select([@socket], nil, nil, READ_TIMEOUT)
        retry if ready

        return false
      end

      private

      def format_bytes_as_hex(bytes)
        bytes.map { |s| format("0x%02X", s) }
      end
    end
  end
end
