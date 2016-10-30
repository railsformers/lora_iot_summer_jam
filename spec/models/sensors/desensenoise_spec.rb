require 'rails_helper'

describe Sensors::Desensenoise do

  let(:message) { double(payloadHex: "0aff880d390fa0") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".noise" do
    subject { sensor.noise }

    it { expect(subject).to eq(40.0) }
  end

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq(3.385) }
  end
end
