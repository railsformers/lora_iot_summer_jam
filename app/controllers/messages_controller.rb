class MessagesController < ApplicationController
  def index
    @messages = Message.get(params[:device_id])
  end
end
