module Sensors
  module Payloads
    class Dth < BinData::Record
      endian :little

      bit1 :adr_flag
      bit3 :dr_flag
      bit1 :snr_flag
      bit3 :len_flag

      int8 :snr
      int8 :battery1
      int8 :battery2
      int8 :temp_units
      int8 :temp_tenths
      int8 :hum_units
      int8 :hum_tenths
      int8 :sup
    end
  end
end
