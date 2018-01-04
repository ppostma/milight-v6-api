# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milight::V6::All do
  let(:command) { double(Milight::V6::Command) }

  subject { Milight::V6::All.new(command) }

  describe "#on" do
    it "sends a command to switch lights on" do
      expect(command).to receive(:on).with(0)
      subject.on
    end

    it "can be chained" do
      expect(command).to receive(:on).with(0)
      expect(subject.on).to eq(subject)
    end
  end

  describe "#off" do
    it "sends a command to switch lights off" do
      expect(command).to receive(:off).with(0)
      subject.off
    end

    it "can be chained" do
      expect(command).to receive(:off).with(0)
      expect(subject.off).to eq(subject)
    end
  end

  describe "#night_light" do
    it "sends a command to switch night light on" do
      expect(command).to receive(:night_light).with(0)
      subject.night_light
    end

    it "can be chained" do
      expect(command).to receive(:night_light).with(0)
      expect(subject.night_light).to eq(subject)
    end
  end

  describe "#brightness" do
    it "sends a command to change brightness" do
      expect(command).to receive(:brightness).with(0, 50)
      subject.brightness(50)
    end

    it "can be chained" do
      expect(command).to receive(:brightness).with(0, 50)
      expect(subject.brightness(50)).to eq(subject)
    end
  end

  describe "#temperature" do
    it "sends a command to change color temperature" do
      expect(command).to receive(:temperature).with(0, 10)
      subject.temperature(10)
    end

    it "can be chained" do
      expect(command).to receive(:temperature).with(0, 10)
      expect(subject.temperature(10)).to eq(subject)
    end
  end

  describe "#warm_light" do
    it "sends a command to change color temperature to warm light" do
      expect(command).to receive(:temperature).with(0, 0)
      subject.warm_light
    end

    it "can be chained" do
      expect(command).to receive(:temperature).with(0, 0)
      expect(subject.warm_light).to eq(subject)
    end
  end

  describe "#white_light" do
    it "sends a command to change color temperature to white light" do
      expect(command).to receive(:temperature).with(0, 100)
      subject.white_light
    end

    it "can be chained" do
      expect(command).to receive(:temperature).with(0, 100)
      expect(subject.white_light).to eq(subject)
    end
  end

  describe "#hue" do
    it "sends a command to change hue" do
      expect(command).to receive(:hue).with(0, 255)
      subject.hue(255)
    end

    it "can be chained" do
      expect(command).to receive(:hue).with(0, 255)
      expect(subject.hue(255)).to eq(subject)
    end
  end

  describe "#saturation" do
    it "sends a command to change saturation" do
      expect(command).to receive(:saturation).with(0, 128)
      subject.saturation(128)
    end

    it "can be chained" do
      expect(command).to receive(:saturation).with(0, 128)
      expect(subject.saturation(128)).to eq(subject)
    end
  end

  describe "#wait" do
    it "waits before continuing to next command" do
      started = Time.now
      subject.wait(0.2)
      stopped = Time.now

      expect(stopped - started).to be >= 0.2
    end

    it "can be chained" do
      expect(subject.wait(0.2)).to eq(subject)
    end
  end
end
