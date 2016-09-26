module Sensors
  module Payloads
    class S0 < BinData::Record
      endian :little

      bit1 :adr_flag
      bit3 :dr_flag
      bit1 :snr_flag
      bit3 :len_flag

      int8 :snr
      int8 :battery1
      int8 :battery2
      int16be :impulse_cnt
      int16be :impulse_cnt1
      int16be :impulse_cnt2
      int16be :impulse_cnt3
    end
  end
end
