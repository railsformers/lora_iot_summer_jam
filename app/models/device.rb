class Device < BaseREST
  # include Her::Model

  # primary_key 'projectId'
  #
  # collection_path "/device/get/:projectId"
  #
  # resource_path "/device/get/:projectId"
  #
  # has_many :messages
  # belongs_to :project

  def messages
    Message.get(self.devEUI)
  end
end
