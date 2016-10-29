class MessageSerializer < ActiveModel::Serializer
  def attributes(*attrs)
    data = super(attrs)
    data[:created_at] = object.created_at
    data[:device_id] = object.device.devEUI
    object.attributes.each do |name, value|
      data[name] = value
    end

    data
  end
end
