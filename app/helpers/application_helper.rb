module ApplicationHelper

  def static_map_image(from, to, &block)
    img = GoogleMaps::StaticImage.new(from, to)
    img.instance_eval(&block) if block_given?
    img.to_url
  end

end
