require 'rails_helper'

describe Sensors::Desense do

  let(:message) { double(payloadHex: "03ffff0dd03b1e5b4b") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".temperature" do
    subject { sensor.temperature }

    it { expect(subject).to eq 15.134 }
  end

  describe ".humidity" do
    subject { sensor.humidity }

    it { expect(subject).to eq 23.371 }
  end

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq 3.536 }
  end
end
