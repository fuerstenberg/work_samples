module MapHelper

  def map(options = {})
    content_for :map, true
    render_map options
  end

  def render_map(options = {})
    options.reverse_merge!({
      collection:           false,
      display_current_user: true,
      highlight_item:       false,
    })

    if options[:highlight_item]
      options[:highlight_item] = "#{ options[:highlight_item].class }Serializer".constantize.new(options[:highlight_item]).serializable_hash
    end

    gon.push({ map_options: options })
  end


  def distance_from_me_to(object, tag = :span)
    if object.geocoded?
      haml_tag tag, "", class: :distance_from_me_to, data: {latitude: object.to_coordinates[0], longitude: object.to_coordinates[1]}
    end
  end

end
