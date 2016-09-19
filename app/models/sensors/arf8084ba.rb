module Sensors
  class Arf8084ba < Sensors::Base
    attributes :temperature, :latitude, :longitude

    def temperature
    end

    def latitude
      lat = (10 * values.lat_tens_degrees) + values.lat_units_degrees
      lat_min = (10 * values.lat_tens_minutes) + values.lat_units_minutes
      lat_min += (values.lat_tenths_minutes / 10.0) + (values.lat_hundredths_minutes / 100.0)
      lat_min += (values.lat_thousandths_minutes / 1000.0)
      lat_min /= 60.0
      lat += lat_min
      byebug
    end

    def longitude
    end
  end
end
