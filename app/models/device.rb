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

  def project
    @project ||= Rails.cache.fetch("device/project/#{self.devEUI}", expires: 24.hour) do
      Project.all.select { |p| p.projectId == self.projectId }.first
    end
  end
end
