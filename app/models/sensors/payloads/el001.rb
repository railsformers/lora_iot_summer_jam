module Sensors
  module Payloads
    class El001 < BinData::Record
      endian :big

      int8 :status
      int32 :energy_plus
      int32 :energy_minus
    end
  end
end
