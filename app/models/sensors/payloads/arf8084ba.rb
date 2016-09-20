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

      uint8 :temperature, onlyif: :is_temp
      bit4 :lat_tens_degrees, onlyif: :is_gps
      bit4 :lat_units_degrees, onlyif: :is_gps
      bit4 :lat_tens_minutes, onlyif: :is_gps
      bit4 :lat_units_minutes, onlyif: :is_gps
      bit4 :lat_tenths_minutes, onlyif: :is_gps
      bit4 :lat_hundredths_minutes, onlyif: :is_gps
      bit4 :lat_thousandths_minutes, onlyif: :is_gps
      bit3 :unused1, onlyif: :is_gps
      bit1 :lat_hemisphere, onlyif: :is_gps
      bit4 :lng_hundreds_degrees, onlyif: :is_gps
      bit4 :lng_tens_degrees, onlyif: :is_gps
      bit4 :lng_units_degrees, onlyif: :is_gps
      bit4 :lng_tens_minutes, onlyif: :is_gps
      bit4 :lng_units_minutes, onlyif: :is_gps
      bit4 :lng_tenths_minutes, onlyif: :is_gps
      bit4 :lng_hundredths_minutes, onlyif: :is_gps
      bit3 :unused2, onlyif: :is_gps
      bit1 :lng_hemisphere, onlyif: :is_gps
      uint8 :uplink, onlyif: :is_up
      uint8 :downlink, onlyif: :is_down
      #uint8 :msb_battery, onlyif: :is_batt
      #uint8 :lsb_battery, onlyif: :is_batt
      #uint8 :rssi, onlyif: :is_rssi
      #uint8 :snr, onlyif: :is_rssi
    end
  end
end
