class MessagesController < ApplicationController
  respond_to :html, :json

  def index
    limit = 200000
    @messages = Array(Message.limit(params[:limit].to_i || 25).page(params[:page]).get(params[:device_id]))
    @messages_array = Kaminari.paginate_array(@messages, total_count: limit).page(params[:page]).per(params[:limit].to_i)
    @device = @messages.try(:first).try(:device)
    @project = @device.try(:project)

    respond_with @messages_array, root: :data, meta: { total_count: limit }
  end

  def chart
    @limit = params[:limit].to_i
    @limit = 25 if @limit.zero?
    @offset = params[:page].to_i * @limit
    @messages_chart = Message.limit(@limit * 4).offset(@offset).get(params[:device_id])

    render json: chart_data(@messages_chart, params[:settings])
  end

  private

  def chart_data(data, settings)
    msg = data.send("group_by_#{settings[:group_by]}", &:created_at)
    arr = []

    settings[:attributes].each do |a|
      arr << { name: a.to_s.humanize, data: msg.select{ |k, v| v.map{ |va| va.attributes.send(a) }.first != nil }.map { |k, v| [k.strftime("%d. %m. %Y %k:%M"), v.map{ |va| va.attributes.send(a) }.first ] } }
    end

    arr
  end
end
