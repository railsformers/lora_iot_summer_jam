class MessagesController < ApplicationController
  respond_to :html, :json
  helper_method :attr_unit

  def index
    limit = 200000
    @messages = Array(Message.limit(params[:limit].to_i || 25).page(params[:page]).get(params[:device_id]))
    @messages_array = Kaminari.paginate_array(@messages, total_count: limit).page(params[:page]).per(params[:limit].to_i)
    @device = @messages.try(:first).try(:device)
    @project = @device.try(:project)
    @displays = @messages.try(:first).try(:display)

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
      arr << { name: a.to_s.humanize + " " + attr_unit(data.first, a.to_s), data: msg.select{ |k, v| v.map{ |va| va.attributes.send(a) }.first != nil }.map { |k, v| [k.strftime("%d. %m. %Y %k:%M"), v.map{ |va| va.attributes.send(a) }.first ] } }
    end

    arr
  end

  def attr_unit(message, attribute)
    return nil unless message

    unit = message.attribute_unit(attribute)
    "#{unit.blank? ? unit : "[" + unit + "]"}"
  end
end
