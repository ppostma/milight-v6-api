# frozen_string_literal: true

require "logger"
require "socket"

module Milight
  module V6
    class Socket
      READ_TIMEOUT = 5

      attr_reader :host, :port

      def initialize(host, port)
        @host = host
        @port = port
      end

      def send_bytes(bytes)
        logger.debug("Sending: #{format_bytes_as_hex(bytes)}")

        socket.send(bytes.pack('C*'), 0, @host, @port)
      end

      def receive_bytes
        response, address = socket.recvfrom_nonblock(128)
        bytes = response.unpack('C*')

        logger.debug("Received: #{format_bytes_as_hex(bytes)}")

        [bytes, address.last]
      rescue IO::WaitReadable
        ready = IO.select([socket], nil, nil, READ_TIMEOUT)
        retry if ready

        return nil
      end

      def close
        socket.close
      end

      private

      def socket
        @socket ||= begin
          socket = UDPSocket.new

          if @host == "<broadcast>" || @host == "255.255.255.255"
            socket.setsockopt(::Socket::SOL_SOCKET, ::Socket::SO_BROADCAST, true)
          end

          socket
        end
      end

      def logger
        @logger ||= begin
          logger = Logger.new(STDOUT)
          logger.level = Logger::INFO if ENV["MILIGHT_DEBUG"] != "1"
          logger
        end
      end

      def format_bytes_as_hex(bytes)
        bytes.map { |s| format("0x%02X", s) }.join(", ")
      end
    end
  end
end
