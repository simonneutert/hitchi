# pass results to the view/controller by
# calling this service object's attributes
#
# if params[:fahrtsuche].present? || params[:zielsuche].present?
#   search = OffersSearch.new(@searchdate, params[:fahrtsuche], params[:zielsuche], show_seeks=false)
#   @offers = search.offers
# end

class OffersSearch
  include OffersFindSearchHelper
  attr_accessor :offers, :searchdate, :between_stops
  def initialize(searchdate, departure, destination, show_seeks=false)
    @offers
    @between_stops
    @departure = departure
    @destination = destination
    @searchdate = searchdate
    @show_seeks = show_seeks
    search_offers
  end

  def search_offers
    case
    when @departure && @destination.blank?
      departure_find_near
      departure_given
    when @departure.blank? && @destination
      destination_find_near
      destination_given
    when @departure && @destination
      departure_find_near
      destination_find_near
      all_params_given
    end
  end

  def output_results
    # this binds the result to the proper attributes
    @offers = find('Offer')
    offer_outputmapping if @offers
  end

  # returning hits over a helping instance
  # instance = x.constantize
  # for Mitfahrgelegenheiten and Mitfahrgesuche
  def departure_given

    def find(x)
      instance = x.constantize
      #find exact
      @r_offers = instance.find_active(@searchdate, @show_seeks).fahrtsuche(@departure).order('departuredate ASC')
      offer_classeval(@r_offers, false, false)
      #find nearby
      @r_offersdiameter = instance.find_active(@searchdate, @show_seeks).where(departure_id: @deppluck).order('departuredate ASC')
      offer_classeval(@r_offersdiameter, 'isdiameterdep', false)
      # return
      @r_offers = (@r_offers + @r_offersdiameter).uniq
    end

    output_results
  end

  def destination_given

    def find(x)
      instance = x.constantize
      # find exact
      @r_offers = instance.find_active(@searchdate, @show_seeks).zielsuche(@destination).order('departuredate ASC')
      offer_classeval(@r_offers, false, false)
      # find nearby
      @r_offersdiameter = instance.find_active(@searchdate, @show_seeks).where(destination_id: @destipluck).order('departuredate ASC')
      offer_classeval(@r_offersdiameter, false, 'isdiameterdest')
      # return
      @r_offers = (@r_offers + @r_offersdiameter).uniq
    end

    output_results
  end

  def all_params_given

    def find(x)
      instance = x.constantize
      # finde alle exakten treffer
      @r_offers = instance.find_active(@searchdate, @show_seeks).fahrtsuche(@departure).zielsuche(@destination).order('departuredate ASC')
      offer_classeval(@r_offers, false, false)
      @r_offers = @r_offers.distinct
      # find nearby destination, exact departure
      @r_offersdiameter = instance.find_active(@searchdate, @show_seeks).where(departure_id: @deppluck).zielsuche(@destination).order('departuredate ASC')
      offer_classeval(@r_offersdiameter, 'isdiameterdep', false)
      @r_offers += @r_offersdiameter
      # find nearby departure, exact destination
      @r_offersdiameter = instance.find_active(@searchdate, @show_seeks).where(destination_id: @destipluck).fahrtsuche(@departure).order('departuredate ASC')
      offer_classeval(@r_offersdiameter, false, 'isdiameterdest')
      @r_offers += @r_offersdiameter
      # find nearby destination and departure
      @r_offersdiameter = instance.find_active(@searchdate, @show_seeks).where(destination_id: @destipluck, departure_id: @deppluck).order('departuredate ASC')
      offer_classeval(@r_offersdiameter, 'isdiameter', 'isdiameter')
      @r_offers += @r_offersdiameter
      # find between_stops from dep to between_stop
      @r_offers += instance.find_active(@searchdate, @show_seeks).order('departuredate ASC').fahrtsuche(@departure).stopsuche(@destination)
      # find between_stops from between_stop to dest
      @r_offers += instance.find_active(@searchdate, @show_seeks).order('departuredate ASC').stopsuche(@departure).zielsuche(@destination)
      # starting to search for between_stop to between_stop
      @between_stops = instance.find_active(@searchdate, @show_seeks).order('departuredate ASC').stopsuche(@departure).stopsuche(@destination)
      # prepare and return the love
      @r_offers.uniq!

      if @r_offers && @between_stops
        find_between_stops
        @r_offers += @between_stops
      end

      @r_offers
    end

    output_results
  end
end
