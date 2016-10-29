class DevicesController < ApplicationController
  def index
    @devices = Device.get(params[:project_id])
    @project = @devices.try(:first).try(:project)
  end
end
