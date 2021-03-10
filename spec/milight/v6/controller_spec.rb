# frozen_string_literal: true

require "spec_helper"

RSpec.describe Milight::V6::Controller do
  let(:command) { double(Milight::V6::Command) }

  before { allow(Milight::V6::Command).to receive(:new).and_return(command) }

  subject { Milight::V6::Controller.new }

  describe "#all" do
    it "returns an instance of type Milight::V6::All" do
      expect(subject.all).to be_instance_of(Milight::V6::All)
    end
  end

  describe "#zone" do
    it "returns an instance of type Milight::V6::Zone" do
      expect(subject.zone(1)).to be_instance_of(Milight::V6::Zone)
    end
  end

  describe "#bridge" do
    it "returns an instance of type Milight::V6::Bridge" do
      expect(subject.bridge).to be_instance_of(Milight::V6::Bridge)
    end
  end
end
