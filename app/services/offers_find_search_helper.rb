module OffersFindSearchHelper
  def offer_classeval(x, y, z)
    x.each do |offer|
      offer.class_eval do
        attr_accessor :diameterdep
        attr_accessor :diameterdest
      end
      offer.diameterdep = y
      offer.diameterdest = z
    end
  end

  def offer_outputmapping
    @offers.uniq!
    @offersusers = @offers.pluck(:user_id)
    @users = User.where(id: @offersusers).distinct!
  end

  def departure_find_near
    @near_departure = Departure.find_by('name ilike ?', @departure)
    @departures = Departure.near(@near_departure, 40)
    @deppluck = @departures.map(&:id) # don't touch this!!!
  end

  def destination_find_near
    @near_destination = Destination.find_by('name ilike ?', @destination)
    @destinations = Destination.near(@near_destination, 40)
    @destipluck = @destinations.map(&:id) # don't touch this!!!
  end

  # sucht Fahrten von x nach y in den between_stops
  # abfahrt und zielparameter werden komplett vernachlässigt
  def find_between_stops
    @between_stops.each do |bs|
      bs.class_eval do
        attr_accessor :truebetweenstop
      end

      bs.truebetweenstop = false
      bsa = bs.between_stops.gsub(/, /, ',').downcase
      bsa = bsa.split(',')

      case
      when bsa.count > 1 && bsa.index(@departure.downcase).to_i < bsa.index(@destination.downcase).to_i
        bs.truebetweenstop = true
      when bsa.count <= 1
        bs.truebetweenstop = true
      end
    end
    
    @between_stops = @between_stops.reject { |offer| offer.truebetweenstop == false }
  end
end
