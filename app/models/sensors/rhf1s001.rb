module Sensors
  class Rhf1s001 < Base

    # def parse
    #   # value.gsub(/../) { |pair| pair.hex.chr }.unpack("B7vvvv")
    #   # "016c689d39309029c8".gsub(/../) { |pair| pair.hex.chr }.unpack("B8vCvS<CC")
    # end

    attributes :temperature, :humidity, :battery_level
    display_as :line_chart, group_by: :minute, attributes: [:temperature, :humidity, :battery_level]

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def temperature
      (((value.temperature*175.72)/(2**16))-46.85).round(2)
    end

    def humidity
      (((125.0*value.humidity)/2**8)-6.0).round
    end

    def period
      2.0*value.period
    end

    def rssi
      -180.0+value.rssi
    end

    def snr
      value.snr/4.0
    end

    def battery_level
      (value.battery+150)*0.01
    end

    def attribute_units
      units = super
      units.merge({ battery_level: "V" })
    end
  end
end
