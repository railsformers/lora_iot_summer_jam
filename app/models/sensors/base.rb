module Sensors
  class Base
    attr_reader :message, :value

    class DefaultFormat < BinData::Record
      endian :little
    end

    def initialize(message:)
      @message = message
    end

    def formatter
      "Sensors::Payloads::#{self.class.name.demodulize}".constantize || DefaultFormat
    end

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def value
      value ||= formatter.read(payloadHexa)
    end
  end
end
