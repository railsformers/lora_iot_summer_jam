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
      message.payloadHex
    end

    def value
      @value ||= formatter.read(payloadHexa) if formatter
    end
    alias_method :values, :value

    def self.attributes(*attrs)
      @@attributes = attrs
    end

    def attributes
      out = {}

      @@attributes.each do |a|
        if respond_to?(a)
          out[a] = send(a)
        end
      end

      out
    end
  end
end
