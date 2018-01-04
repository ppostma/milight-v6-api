# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milight::V6::Command do
  let(:socket) { double(Milight::V6::Socket) }

  before do
    allow(Milight::V6::Socket).to receive(:new).and_return(socket)
    allow(socket).to receive(:send_bytes)
    allow(socket).to receive(:receive_bytes).and_return(
      [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x20, 0x00]
    )
  end

  subject { Milight::V6::Command.new("127.0.0.1") }

  describe "session" do
    it "sends the bridge session command" do
      expect(socket).to receive(:send_bytes).with(
        [0x20, 0x00, 0x00, 0x00, 0x16, 0x02, 0x62, 0x3A, 0xD5, 0xED, 0xA3, 0x01, 0xAE, 0x08,
         0x2D, 0x46, 0x61, 0x41, 0xA7, 0xF6, 0xDC, 0xAF, 0xD3, 0xE6, 0x00, 0x00, 0x1E]
      )
      subject.execute(1, [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
    end
  end

  describe "#execute" do
    it "raises an exception when zone_id is too low" do
      expect { subject.execute(-1, [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) }.to raise_error ArgumentError
    end

    it "raises an exception when zone_id is too high" do
      expect { subject.execute(5, [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]) }.to raise_error ArgumentError
    end

    it "sends the command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02]
      )
      subject.execute(1, [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
    end
  end

  describe "#link" do
    it "sends the link command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x3D, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x46]
      )
      subject.link(1)
    end
  end

  describe "#unlink" do
    it "sends the unlink command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x3E, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x47]
      )
      subject.unlink(1)
    end
  end

  describe "#on" do
    it "sends the on command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x04, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x3F]
      )
      subject.on(1)
    end
  end

  describe "#off" do
    it "sends the off command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x04, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x40]
      )
      subject.off(1)
    end
  end

  describe "#night_light" do
    it "sends the night_light command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x04, 0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x43]
      )
      subject.night_light(1)
    end
  end

  describe "#brightness" do
    it "raises an exception when value is too low" do
      expect { subject.brightness(1, -1) }.to raise_error ArgumentError
    end

    it "raises an exception when value is too high" do
      expect { subject.brightness(1, 101) }.to raise_error ArgumentError
    end

    it "sends the brightness command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x03, 0x64, 0x00, 0x00, 0x00, 0x01, 0x00, 0xA1]
      )
      subject.brightness(1, 100)
    end
  end

  describe "#temperature" do
    it "raises an exception when value is too low" do
      expect { subject.temperature(1, -1) }.to raise_error ArgumentError
    end

    it "raises an exception when value is too high" do
      expect { subject.temperature(1, 101) }.to raise_error ArgumentError
    end

    it "sends the temperature command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x05, 0x64, 0x00, 0x00, 0x00, 0x01, 0x00, 0xA3]
      )
      subject.temperature(1, 100)
    end
  end

  describe "#hue" do
    it "raises an exception when value is too low" do
      expect { subject.hue(1, -1) }.to raise_error ArgumentError
    end

    it "raises an exception when value is too high" do
      expect { subject.hue(1, 256) }.to raise_error ArgumentError
    end

    it "sends the hue command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x37]
      )
      subject.hue(1, 255)
    end
  end

  describe "#saturation" do
    it "raises an exception when value is too low" do
      expect { subject.saturation(1, -1) }.to raise_error ArgumentError
    end

    it "raises an exception when value is too high" do
      expect { subject.saturation(1, 101) }.to raise_error ArgumentError
    end

    it "sends the saturation command" do
      expect(socket).to receive(:send_bytes).with(
        [0x80, 0x00, 0x00, 0x00, 0x11, 0x10, 0x20, 0x00, 0x01, 0x00,
         0x31, 0x00, 0x00, 0x08, 0x02, 0x32, 0x00, 0x00, 0x00, 0x01, 0x00, 0x6E]
      )
      subject.saturation(1, 50)
    end
  end
end
