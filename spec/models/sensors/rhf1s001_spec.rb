require 'rails_helper'

describe Sensors::Rhf1s001 do

  let(:message) { double(payloadHex: "016c689d39309029c8") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".temperature" do
    subject { sensor.temperature }

    it { expect(subject).to eq 24.83 }
  end

  describe ".humidity" do
    subject { sensor.humidity }

    it { expect(subject).to eq 71 }
  end

  describe ".period" do
    subject { sensor.period }

    it { expect(subject).to eq 24690 }
  end

  describe ".rssi" do
    subject { sensor.rssi }

    it { expect(subject).to eq -36 }
  end

  describe ".snr" do
    subject { sensor.snr }

    it { expect(subject).to eq 10.25 }
  end

  describe ".battery_level" do
    subject { sensor.battery_level }

    it { expect(subject).to eq 3.5 }
  end
end
