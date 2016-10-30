module Sensors
  class El001 < Base
    attributes :energy_minus, :energy_plus

    display_as :line_chart, group_by: :minute, attributes: [:energy_minus, :energy_plus]

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def energy_minus
      @energy_minus ||= values.energy_minus / 100.0
    end

    def energy_plus
      @energy_plus ||= values.energy_plus / 100.0
    end

    def attribute_units
      { energy_plus: "kWh", energy_minus: "kWh" }
    end
  end
end
