module Sensors
  class Desenselight < DesenseBase
    attributes :illuminance
    display_as :line_chart, group_by: :minute, attributes: [:illuminance]

    def illuminance
      @illuminance ||= values.illuminance / 1000.0
    end
  end
end
