module Sensors
  class Rhf1s001 < Base

    # def parse
    #   # value.gsub(/../) { |pair| pair.hex.chr }.unpack("B7vvvv")
    #   # "016c689d39309029c8".gsub(/../) { |pair| pair.hex.chr }.unpack("B8vCvS<CC")
    # end

    def temperature
      ((value.temperature*175.72)/(2**16))-46.85
    end

    def humidity
    end
  end
end
