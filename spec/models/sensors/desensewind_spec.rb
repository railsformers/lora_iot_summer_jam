require 'rails_helper'

describe Sensors::Desensewind do
  let(:sensor) { described_class.new(message: message) }

  context "when normal values" do
    let(:message) { double(payloadHex: "08ff850b650afb0a76") }

    describe ".wind_speed" do
      subject { sensor.wind_speed }

      it { expect(subject).to eq(6.8) }
    end

    describe ".temperature" do
      subject { sensor.temperature }

      it { expect(subject).to eq(13.3) }
    end

    describe ".battery_voltage" do
      subject { sensor.battery_voltage }

      it { expect(subject).to eq(2.917) }
    end
  end

  context "when high values" do
    let(:message) { double(payloadHex: "08ff840bbb10ec0d19") }

    describe ".wind_speed" do
      subject { sensor.wind_speed }

      it { expect(subject).to eq(368.0) }
    end

    describe ".temperature" do
      subject { sensor.temperature }

      it { expect(subject).to eq(-1.5) }
    end

    describe ".battery_voltage" do
      subject { sensor.battery_voltage }

      it { expect(subject).to eq(3.003) }
    end
  end
end
