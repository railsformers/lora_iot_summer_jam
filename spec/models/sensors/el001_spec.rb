require 'rails_helper'

describe Sensors::El001 do

  let(:message) { double(payloadHex: "210000000000001140") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".energy_minus" do
    subject { sensor.energy_minus }

    it { expect(subject).to eq(44.16) }
  end

  describe ".energy_plus" do
    subject { sensor.energy_plus }

    it { expect(subject).to eq(0.0) }
  end
end
