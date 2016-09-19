module Sensors
  module Payloads
    class Arf8084ba < BinData::Record
      endian :little

      bit1 :is_temp
      bit1 :is_acc
      bit1 :is_btn1
      bit1 :is_gps
      bit1 :is_up
      bit1 :is_down
      bit1 :is_batt
      bit1 :is_rssi

      uint8 :temperature
      bit4 :lat_tens_degrees
      bit4 :lat_units_degrees
      bit4 :lat_tens_minutes
      bit4 :lat_units_minutes
      bit4 :lat_tenths_minutes
      bit4 :lat_hundredths_minutes
      bit4 :lat_thousandths_minutes
      bit3 :unused1
      bit1 :lat_hemisphere
      #uint8 :lat_minutes1
      #uint8 :lat_minutes2
      #uint8 :lat_minutes3
      #uint32 :latitude
      #uint32 :longitude
      #uint8 :uplink
      #uint8 :downlink
      #uint8 :msb_battery
      #uint8 :lsb_battery
      #uint8 :rssi
      #uint8 :snr
    end
  end
end
