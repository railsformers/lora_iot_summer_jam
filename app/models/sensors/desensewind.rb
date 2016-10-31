module Sensors
  class Desensewind < DesenseBase
    attributes :temperature, :wind_speed
    display_as :line_chart, group_by: :minute, attributes: [:wind_speed, :temperature]

    def air_flow
      @air_flow ||= values.air_flow / 1000.0
    end

    def temp
      @temp ||= values.temperature / 1000.0
    end

    def temperature
      @temperature ||= ((209.7152 * (temp ** 2) - (3453.3376 * temp) +  9075.4) / 100.0).round(1)
      # @temperature ||= 0.005 * (temp ** 2) - (16.862 * (temp ** 2)) + 9075.4
    end

    def zero_wind_speed
      @wind_speed ||= (-0.1229 * (temp ** 2)) + (1.0727 * temp) + 0.2303
      # wind_speed = -0.0006 * (temp ** 2) + 1.0727 * temp + 47.172
      # @wind_speed ||= (wind_speed * 0.0048828125) - 0.2
    end

    def wind_volts
      @wind_volts ||= air_flow *  0.0048828125
    end

    def wind_speed_mph
      @wind_speed_mph ||= ((air_flow - zero_wind_speed - 0.2) / 0.23) ** 2.7265
      # @wind_speed_mph ||= ((wind_volts - zero_wind_speed) / 0.23) ** 2.7265
    end

    def wind_speed_kph
      @wind_speed_kph ||= (wind_speed_mph * 1.6093).round(1)
    end
    alias_method :wind_speed, :wind_speed_kph

    def attribute_units
      units = super
      units.merge({ wind_speed: "km/s", temperature: "°C" })
    end
  end
end
