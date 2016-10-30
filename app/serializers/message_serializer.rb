class MessageSerializer < ActiveModel::Serializer
  def attributes(*attrs)
    data = super(attrs)
    data[:created_at] = object.created_at
    data[:device_id] = object.device.devEUI
    object.attributes.each do |name, value|
      if object.device.model == "ARF8084BA"
        data[name] = value.to_f
      else
        data[name] = value
      end
    end

    data
  end
end
