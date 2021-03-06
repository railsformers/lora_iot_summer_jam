module Sensors
  class Desense < DesenseBase
    attributes :temperature, :humidity
    display_as :line_chart, group_by: :minute, attributes: [:temperature, :humidity]

    def temperature
      @temperature ||= values.temperature / 1000.0
    end

    def humidity
      @humidity ||= values.humidity / 1000.0
    end
  end
end
