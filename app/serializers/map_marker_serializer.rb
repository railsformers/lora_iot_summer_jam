class MapMarkerSerializer < ActiveModel::Serializer
  attribute :latitude, key: :lat
  attribute :longitude, key: :lng
  attribute :infowindow, key: :infowindow

  delegate :latitude, :longitude, to: :attrs

  def attrs
    object.attributes
  end

  def infowindow
    object.created_at.strftime("%d.%m.%Y %H:%M:%S")
  end
end
