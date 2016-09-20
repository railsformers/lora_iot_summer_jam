require 'rails_helper'

describe Sensors::Arf8084ba do

  let(:message) { double(payloadHex: "9e1a5006234001407190140a0cd8") }
  let!(:sensor) { described_class.new(message: message) }

  describe ".temperature" do
    subject { sensor.temperature }

    it { expect(subject).to eq 26 }
  end

  describe ".latitude" do
    subject { sensor.latitude }

    it { expect(subject).to eq 50.1039 }
  end

  describe ".longitude" do
    subject { sensor.longitude }

    it { expect(subject).to eq 14.119833 }
  end
end
