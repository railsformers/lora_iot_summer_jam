module Sensors
  class Desensesoil < Base
    attributes :soil_moisture, :battery_voltage
    display_as :line_chart, group_by: :minute, attributes: [:soil_moisture]

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def soil_moisture
      @soil_moisture ||= (values.soil_moisture > 2400 ? 100 : (values.soil_moisture/2400.0)*100.0).to_i
    end

    def battery_voltage
      @battery_voltage ||= values.battery / 1000.0
    end
  end
end
