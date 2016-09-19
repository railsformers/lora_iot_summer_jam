class DevicesController < ApplicationController
  def index
    @devices = Device.get(params[:project_id])
  end
end
