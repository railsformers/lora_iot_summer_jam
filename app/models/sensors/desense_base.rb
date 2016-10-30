module Sensors
  class DesenseBase < Base
    attributes :battery_voltage

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def battery_voltage
      @battery_voltage ||= values.battery / 1000.0
    end

    def attribute_units
      units = super
      units.merge({ battery_voltage: "V" })
    end
  end
end
