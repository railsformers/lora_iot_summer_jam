class MessagesController < ApplicationController
  def index
    limit = 200000
    @messages = Array(Message.limit(25).page(params[:page]).get(params[:device_id]))
    @messages_array = Kaminari.paginate_array(@messages, total_count: limit).page(params[:page]).per(25)
  end
end
