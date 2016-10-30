module Sensors
  class Arf8084ba < Sensors::Base
    attributes :temperature, :latitude, :longitude
    display_as :map, group_by: :minute, attributes: [:temperature, :latitude, :longitude]

    def payloadHexa
      message.payloadHex.scan(/../).map { |x| x.hex.chr }.join
      #message.payloadHex.scan(/../).map { |x| x.hex }.pack("c*")
    end

    def temperature
      values.temperature if values.is_temp
    end

    def latitude
      lat = (10 * values.lat_tens_degrees) + values.lat_units_degrees
      lat_min = (10 * values.lat_tens_minutes) + values.lat_units_minutes
      lat_min += (values.lat_tenths_minutes / 10.0) + (values.lat_hundredths_minutes / 100.0)
      lat_min += (values.lat_thousandths_minutes / 1000.0)
      lat_min /= 60.0
      lat += lat_min
      lat.round(6)
    end

    def longitude
      lng = (100 * values.lng_hundreds_degrees) + (10 * values.lng_tens_degrees) + values.lng_units_degrees
      lng_min = (10 * values.lng_tens_minutes) + values.lng_units_minutes
      lng_min += (values.lng_tenths_minutes / 10.0) + (values.lng_hundredths_minutes / 100.0)
      lng_min /= 60.0
      lng += lng_min
      lng.round(6)
    end
  end
end
