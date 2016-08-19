class Sensors::RHF1S001 < Sensors::Base
  def parse
    .gsub(/../) { |pair| pair.hex.chr }.unpack("B7vvvv")
  end

  def temperature
    (("\x#{payloadHex[]}\x#{}".unpack("v").first*175.72)/(2**16))-46.85
  end

  def humidity
  end
end
