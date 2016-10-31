module Sensors
  class Desenselight < DesenseBase
    attributes :illuminance
    display_as :line_chart, group_by: :minute, attributes: [:illuminance]

    def illuminance
      @illuminance ||= values.illuminance.to_i # ??? / 1000.0 ???
    end

    def attribute_units
      units = super
      units.merge({ illuminance: "lx" })
    end
  end
end
