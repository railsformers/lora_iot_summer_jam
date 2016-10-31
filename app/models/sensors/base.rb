module Sensors
  class Base
    attr_reader :message, :value

    with_options instance_writer: false, instance_reader: false do |klasss|
      klasss.class_attribute :_display_as_data
      self._display_as_data ||= {}

      klasss.class_attribute :_sensor_attributes_data
      self._sensor_attributes_data ||= []
    end

    def self.inherited(base)
      super
      base._display_as_data = _display_as_data.dup
      base._sensor_attributes_data = _sensor_attributes_data.dup
    end

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
      self._sensor_attributes_data += attrs
    end

    def self.display_as(type, attrs)
      self._display_as_data[type] = attrs
    end

    def attributes
      out = Hashie::Mash.new

      self.class._sensor_attributes_data.uniq.each do |a|
        if respond_to?(a)
          out[a] = send(a)
        end
      end

      if self.class._sensor_attributes_data.empty?
        out[:not_implemented] = "Not Implemented Sensor Parser"
      end

      out
    end

    def display
      self.class._display_as_data
    end

    def attribute_units
      { humidity: "%", temperature: "°C" }
    end

    def attribute_unit(attribute)
      attribute_units[attribute.to_sym] || ""
    end
  end
end
