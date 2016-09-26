require 'rails_helper'

describe Sensors::Dth do

  let(:message) { double(payloadHex: "2408200315143C1E00") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".temperature" do
    subject { sensor.temperature }

    it { expect(subject).to eq 21.20 }
  end

  describe ".humidity" do
    subject { sensor.humidity }

    it { expect(subject).to eq 60.30 }
  end

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq 3203 }
  end
end
