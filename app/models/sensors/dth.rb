module Sensors
  class Dth < Base
    attributes :temperature, :humidity, :battery_voltage
    display_as :line_chart, group_by: :minute, attributes: [:temperature, :humidity]

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def temperature
      @temperature ||= "#{values.temp_units}.#{values.temp_tenths}".to_f
    end

    def humidity
      @humidity ||= "#{values.hum_units}.#{values.hum_tenths}".to_f
    end

    def battery_voltage
      @battery_voltage ||= (values.battery1 * 100) + values.battery2
    end
  end
end
