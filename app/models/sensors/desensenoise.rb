module Sensors
  class Desensenoise < DesenseBase
    attributes :noise
    display_as :line_chart, group_by: :minute, attributes: [:noise]

    def noise
      @noise ||= values.noise / 100.0
    end

    def attribute_units
      units = super
      units.merge({ noise: "dB" })
    end
  end
end
