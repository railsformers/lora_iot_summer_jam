require 'rails_helper'

describe Sensors::Desensesoil do

  let(:message) { double(payloadHex: "04ff8a0d891ecb") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".soil_moisture" do
    subject { sensor.soil_moisture }

    it { expect(subject).to eq 100 }
  end

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq 3.465 }
  end
end
