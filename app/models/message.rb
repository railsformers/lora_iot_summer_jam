class Message < BaseREST
  cache_expires 1.minute

  def data
    return "Parser not implemented" unless sensor_class

    begin
      sensor.attributes.inspect
    rescue EOFError => err
      return {}
    end
  end

  def sensor_class
    "Sensors::#{device.model.downcase.capitalize}".safe_constantize if device
  end

  def sensor
    @sensor ||= sensor_class.new(message: self) if sensor_class
  end

  def device
    @device ||= Project.all.map { |p| p.devices }.flatten.select{ |d| d.devEUI == self.devEUI }.first
  end
end
