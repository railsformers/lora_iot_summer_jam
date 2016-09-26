require 'rails_helper'

describe Sensors::S0 do

  let(:message) { double(payloadHex: "27802003011A032B001F0000") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".battery_voltage" do
    subject { sensor.battery_voltage }

    it { expect(subject).to eq 3203 }
  end

  describe ".impulse_cnt" do
    subject { sensor.impulse_cnt }

    it { expect(subject).to eq 282 }
  end

  describe ".impulse_cnt1" do
    subject { sensor.impulse_cnt1 }

    it { expect(subject).to eq 811 }
  end

  describe ".impulse_cnt2" do
    subject { sensor.impulse_cnt2 }

    it { expect(subject).to eq 31 }
  end

  describe ".impulse_cnt3" do
    subject { sensor.impulse_cnt3 }

    it { expect(subject).to eq 0 }
  end
end 
