module Sensors
  class S0 < Base
    attributes :impulse_cnt, :impulse_cnt1, :impulse_cnt2, :impulse_cnt3, :battery_voltage

    display_as :line_chart, group_by: :minute, attributes: [:impulse_cnt, :impulse_cnt1, :impulse_cnt2, :impulse_cnt3, :battery_voltage]

    delegate :impulse_cnt, :impulse_cnt1, :impulse_cnt2, :impulse_cnt3, to: :values

    def payloadHexa
      message.payloadHex.gsub(/../) { |pair| pair.hex.chr }
    end

    def battery_voltage
      @battery_voltage ||= recalculate(values.battery1, values.battery2)
    end

    def recalculate(ub, db)
      (ub * 100) + db
    end
  end
end
