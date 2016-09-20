module Sensors
  class Dth < Base
    attributes :temperature, :humidity

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def temperature
      @temperature ||= "#{values.temp_units}.#{values.temp_tenths}".to_f
    end

    def humidity
      @humidity ||= "#{values.hum_units}.#{values.hum_tenths}".to_f
    end
  end
end
