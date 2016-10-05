module Sensors
  class Base
    attr_reader :message, :value

    @@attributes = []
    @@display_as = {}

    class DefaultFormat < BinData::Record
      endian :little
    end

    def initialize(message:)
      @message = message
    end

    def formatter
      "Sensors::Payloads::#{self.class.name.demodulize}".safe_constantize || DefaultFormat
    end

    def payloadHexa
      message.payloadHex
    end

    def value
      @value ||= begin
        formatter.read(payloadHexa) if formatter
      rescue EOFError => e
        formatter.read("\x00" * 30)
      end
    end
    alias_method :values, :value

    def self.attributes(*attrs)
      @@attributes += attrs
    end

    def self.display_as(type, attrs)
      @@display_as[type] = attrs
    end

    def attributes
      out = Hashie::Mash.new

      @@attributes.uniq.each do |a|
        if respond_to?(a)
          out[a] = send(a)
        end
      end

      out
    end

    def display
      @@display_as
    end
  end
end
