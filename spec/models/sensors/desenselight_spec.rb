require 'rails_helper'

describe Sensors::Desenselight do

  let(:message) { double(payloadHex: "04ff8a0d891ecb") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".illuminance" do
    subject { sensor.illuminance }

    it { expect(subject).to eq 7883 }
  end

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq 3.465 }
  end
end
