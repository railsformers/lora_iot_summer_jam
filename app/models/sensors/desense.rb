module Sensors
  class Desense < Base
    attributes :temperature, :humidity, :battery_voltage
    display_as :line_chart, group_by: :minute, attributes: [:temperature, :humidity]

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def temperature
      @temperature ||= values.temperature / 1000.0
    end

    def humidity
      @humidity ||= values.humidity / 1000.0
    end

    def battery_voltage
      @battery_voltage ||= values.battery / 1000.0
    end
  end
end
