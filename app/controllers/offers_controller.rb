class OffersController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:overview, :new, :create, :get_messagecount]

  around_action :catch_not_found
  # security
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  before_action :max_offers, only: [:new, :create]
  # define the searchresults per page
  before_action :searchresultspp, only: [:search, :find]

  # autocomplete live query support via autocomplete gem
  autocomplete :cityname, :name, :full => true

  # GET /offers
  # GET /offers.json
  def index
    redirect_to root_path
  end

  def get_messagecount
    # pure json output for the ajax call in a jquery function (messagecount in navigation)
    respond_to do |format|
      format.json do
        posts = message_counter # message_counter is a global helper_method in ApplicationController
        data = posts
        render(json: data)
      end
    end
  end

  def all
    @offers = Offer.where(active: true)
  end

  def linkout
    # linkout for showing the facebook profile
    @offer = Offer.find(params[:offerid])
    @offer.increment!(:clickcounter, 1) if current_user && @offer.user_id != current_user.id
    @advert = Advert.where(city: @offer.destinationlocal).where("begin_ad <= ?", Date.today).where("end_ad >= ?", Date.today).order(viewcounter: :asc).first
    @advert.increment!(:viewcounter, 1) if @advert
  end

  def msglinkout
    # linkout when creating new message
    @offer = Offer.find(params[:offerid])
    @offer.increment!(:clickcounter, 1) if current_user && @offer.user_id != current_user.id
    @advert = Advert.where(city: @offer.destinationlocal).where("begin_ad <= ?", Date.today).where("end_ad >= ?", Date.today).order(viewcounter: :asc).first
    @advert.increment!(:viewcounter, 1) if @advert
  end

  def adclick
    # this is run when an app is clicked
    @advert = Advert.find(params[:id])
    @advert.increment!(:clickcounter, 1)
    redirect_to @advert.linkurl
  end

  def overview
    # destroy all offers with departuredate in the past
    if current_user
      @lateoffers = current_user.offers.where("departuredate < ?", Date.today)
      @lateoffers.each { |lateoffer| lateoffer.destroy } if @lateoffers
      @offers = current_user.offers.where(active: true).order(departuredate: :asc)
      # matching queries run in the view for proper alignment
      # _overview_offers and _overview_seek
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @departure = Departure.find(@offer.departure_id)
    @destination = Destination.find(@offer.destination_id)
    @depcoords = @departure.latitude.to_s + "," + @departure.longitude.to_s
    @destcoords = @destination.latitude.to_s + "," + @destination.longitude.to_s
    @offeruser = User.find(@offer.user_id)
    @offer.increment!(:viewcounter, 1) unless current_user && @offer.user_id == current_user.id
  end

  def search
    check_date_params("search") # sets @searchdate
    if params[:fahrtsuche].present? || params[:zielsuche].present?
      search = OffersSearch.new(@searchdate, params[:fahrtsuche], params[:zielsuche], show_seeks=false)
      offers = search.offers
      def pagy_get_items(array, pagy)
        array[pagy.offset, pagy.items]
      end
      @pagy, @offers = pagy(offers)
    else # only on empty search
      @searchdate = Date.today
      offer_count = Offer.where(active: true, seek: false).size
      case
      when offer_count > 3
        @offers = Offer.where(active: true, seek: false).sample(4)
      when offer_count > 1
        @offers = Offer.where(active: true, seek: false).sample(2)
      when offer_count == 1
        @offers = Offer.where(active: true, seek: false).sample(1)
      end
    end
  end #search

  def find
    check_date_params("find")
    if params[:fahrtsuche].present? || params[:zielsuche].present?
      search = OffersSearch.new(@searchdate, params[:fahrtsuche], params[:zielsuche], show_seeks=true)
      offers = search.offers
      def pagy_get_items(array, pagy)
        array[pagy.offset, pagy.items]
      end
      @pagy, @offers = pagy(offers)
    end
  end #end of find

  # GET /offers/new
  def new
    @offer = User.find(current_user.id).offers.build()
    @offer.departuredate = Date.today
  end

  # GET /offers/1/edit
  def edit
    # user permission checked via before_action hook
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = current_user.offers.build(offer_params)
    @offer.destinationlocal = @offer.destinationlocal.squish
    @offer.departurelocal = @offer.departurelocal.squish
    @offer.destination_id = Destination.find_or_create_by(name: @offer.destinationlocal).id
    @offer.departure_id = Departure.find_or_create_by(name: @offer.departurelocal).id

    Destination.find(@offer.destination_id).touch
    Departure.find(@offer.departure_id).touch
    @offer.active = true
    @deletedate = @offer.departuredate + 1.days

    if @offer.seek == true
      @offer.between_stops = ""
    else
      @offer.seek = false
      @offer.emailnotification = false
    end

    def send_mail_to_seeks
      @seeksusers = Offer.where(seek: true, active: true, emailnotification: true, departuredate: @offer.departuredate, departurelocal: @offer.departurelocal, destinationlocal: @offer.destinationlocal).pluck(:user_id)
      @users = User.where(id: @seeksusers).where.not(id: current_user.id)
      if @seeksusers.any? && @users.any?
        @users.each do |user|
          next unless user.email
          UserMailer.notification_email(user, @offer).deliver_now
        end
      end
    end

    respond_to do |format|
      if @offer.save
        send_mail_to_seeks if @offer.seek == false # only send mails if created offer is not a seek
        format.html { redirect_to offers_mitfahrgelegenheit_path(@offer), notice: 'Erfolgreich gespeichert! Dein hitchi wird am ' + @deletedate.strftime("%d.%m.%Y").to_s + " automatisch wieder gelöscht werden." }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    # user permission checked via before_action hook
    attributes = offer_params.clone

    respond_to do |format|
      @offer.destination_id = Destination.find_or_create_by(name: attributes[:destinationlocal].squish).id
      @offer.departure_id = Departure.find_or_create_by(name: attributes[:departurelocal].squish).id
      Destination.find(@offer.destination_id).touch
      Departure.find(@offer.departure_id).touch
      if @offer.update(offer_params)

        @offer.update(between_stops: "") if @offer.seek == true
        @offer.update(seek: false, emailnotification: false) unless @offer.seek == true

        format.html { redirect_to offers_mitfahrgelegenheit_path(@offer, facebook_refresh: true), notice: 'Änderungen gespeichert.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    # user permission checked via before_action hook
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_overview_path, notice: 'Deine Anzeige wurde gelöscht.' }
      format.json { head :no_content }
    end
  end


  private

    def check_date_params(str)
      begin
        @searchdate = params[:datumsuche].to_date if params[:datumsuche]
        @searchdate = params[:mysuche].to_date if params[:mysuche]
      rescue NoMethodError
        redirect_to offers_search_path if str == "search"
        redirect_to offers_find_path if str == "find"
        return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    def max_offers
      if current_user.offers.pluck(:id).count >= 6
        redirect_to offers_overview_path, notice: "Das geht leider nicht, Du kannst maximal 6 hitchis erstellen."
      end
    end

    def searchresultspp
      @searchresultspp = 8
    end
    def description=(value)
      self[:description] = value.to_s.squish
    end
    def departuretime=(value)
      self[:departuretime] = value.to_s.squish
    end

    def catch_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, :flash => { :error => "Diese Anzeige ist leider nicht mehr gültig. Bitte nutze die Suche :)" }
      return
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(
      :departurelocal,
      :departuredate,
      :departuretime,
      :destinationlocal,
      :description,
      :between_stops,
      :seek,
      :active,
      :rules,
      :user_id,
      :departure_id,
      :destination_id,
      :emailnotification
      )
    end
end
