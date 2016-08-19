class Project < BaseREST
  # include Her::Model
  #
  # primary_key 'projectId'
  #
  # collection_path "/project/get"
  #
  # resource_path '/project/get'
  #
  # has_many :devices

  def devices
    # Project.all.map{ |p| puts "Projekt: " + p.projectId + " " + p.description; p.devices.each{ |d| puts "Cidlo: " + d.description } }
    Device.get(self.projectId)
  end
end
