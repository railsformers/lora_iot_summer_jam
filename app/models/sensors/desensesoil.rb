module Sensors
  class Desensesoil < DesenseBase
    attributes :soil_moisture
    display_as :line_chart, group_by: :minute, attributes: [:soil_moisture]

    def soil_moisture
      @soil_moisture ||= (values.soil_moisture > 2400 ? 100 : (values.soil_moisture/2400.0)*100.0).to_i
    end

    def attribute_units
      units = super
      units.merge({ soil_moisture: "%" })
    end
  end
end
