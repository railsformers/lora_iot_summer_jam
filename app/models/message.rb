class Message < BaseREST
  # include Her::Model
  #
  # belongs_to :device

  # extend Sensors::Rhf1s001
  def data
    sensor.attributes.inspect
  end

  def sensor_class
    "Sensors::#{device.model.downcase.capitalize}".constantize
  end

  def sensor
    @sensor ||= sensor_class.new(message: self)
  end

  def device
    @projects ||= Project.all
    @device ||= @projects.map { |p| p.devices }.flatten.select{ |d| d.devEUI == self.devEUI }.first
  end
end
