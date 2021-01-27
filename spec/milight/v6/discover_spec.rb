# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milight::V6::Discover do
  subject { Class.new { extend Milight::V6::Discover } }

  describe "#search" do
    let(:socket) { double(Milight::V6::Socket, host: "127.0.0.1", port: 5987) }

    before do
      allow(Milight::V6::Socket).to receive(:new).and_return(socket)
      allow(socket).to receive(:send_bytes)
      allow(socket).to receive(:receive_bytes).and_return(
        [
          [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00] + Milight::V6::Discover::AUTH_TOKEN,
          "127.0.0.1"
        ],
        nil
      )
      allow(socket).to receive(:close)
    end

    it "returns the found controllers" do
      controllers = subject.search
      expect(controllers).to be_instance_of(Array)
      expect(controllers.length).to eq(1)

      controller = controllers.first
      expect(controller).to be_instance_of(Milight::V6::Controller)
      expect(controller.to_s).to eq("Mi-Light Wifi iBox Controller. IP address: 127.0.0.1")
    end
  end
end
