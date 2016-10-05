module ApplicationHelper
  def chart_data(data, settings)
    msg = data.send("group_by_#{settings[:group_by]}", &:createdAt)
    arr = []

    settings[:attributes].each do |a|
      arr << { name: a, data: msg.map { |k, v| [k, v.map{ |va| va.attributes.send(a) }.first ] } }
    end

    arr
  end
end
