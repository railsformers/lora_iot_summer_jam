module Sensors
  class Desenselight < Base
    attributes :illuminance, :battery_voltage

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def illuminance
      @illuminance ||= values.illuminance / 1000.0
    end

    def battery_voltage
      @battery_voltage ||= values.battery / 1000.0
    end
  end
end
