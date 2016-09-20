class Message < BaseREST
  def data
    begin
      sensor.attributes.inspect if sensor
    rescue EOFError => err
      return {}
    end
  end

  def sensor_class
    "Sensors::#{device.model.downcase.capitalize}".constantize if device
  end

  def sensor
    @sensor ||= sensor_class.new(message: self) if sensor_class
  end

  def device
    @device ||= Project.all.map { |p| p.devices }.flatten.select{ |d| d.devEUI == self.devEUI }.first
  end
end
