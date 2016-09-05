module Sensors
  module Payloads
    class Rhf1s001 < BinData::Record
      endian :little

      uint8 :version
      uint16 :temperature
      uint8 :humidity
      uint16 :period
      uint8 :rssi
      uint8 :snr
      uint8 :battery
    end
  end
end
