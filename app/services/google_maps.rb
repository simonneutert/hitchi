module GoogleMaps
  class StaticImage

    API_KEY = ENV['GOOGLE_MAPS_API_KEY']
    BASE_URL = "https://maps.googleapis.com/maps/api/staticmap?"

    attr_accessor :width, :height, :maptype

    def initialize(from, to)
      @from_place_cord = from
      @to_place_cord = to
      @width = 600
      @height = 300
      @maptype = "roadmap"
    end

    def set_dimensions(width, height)
      @width = width
      @height = height
      self
    end

    def maptype(maptype)
      @maptype = maptype
      self
    end

    def to_url
      src = ""
      src << BASE_URL
      src << "&size=#{@width}x#{@height}&maptype="
      src << @maptype
      src << "&markers=color:purple%7Clabel:A%7C"
      src << @from_place_cord
      src << "&markers=color:blue%7Clabel:B%7C"
      src << @to_place_cord
      src << "&key=#{API_KEY}"
      src
    end

  end

end
