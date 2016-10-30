require 'rails_helper'

describe Sensors::El001 do

  let(:message) { double(payloadHex: "210000000000001140") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".energy" do
    subject { sensor.energy }

    it { expect(subject).to eq(44.16) }
  end
end
