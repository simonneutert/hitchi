class Admins::OffersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin_offer, only: [:show, :edit, :update, :destroy]
  before_action :sameadmin, only: [:show, :edit, :update, :destroy]
  before_action :user_logout

  # GET /admin_offers
  # GET /admin_offers.json
  def index
    @admin_offers = Offer.where(active: true, seek: false)
  end

  # GET /admin_offers/1
  # GET /admin_offers/1.json
  def show
  end

  # GET /admin_offers/new
  # def new
  #   @admin_offer = Offer.new
  # end

  # GET /admin_offers/1/edit
  def edit
  end

  # POST /admin_offers
  # POST /admin_offers.json
  # def create
  #   @admin_offer = Offer.new(admin_offer_params)
  #
  #   respond_to do |format|
  #     if @admin_offer.save
  #       format.html { redirect_to @admin_offer, notice: 'Admin offer was successfully created.' }
  #       format.json { render :show, status: :created, location: @admin_offer }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @admin_offer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /admin_offers/1
  # PATCH/PUT /admin_offers/1.json
  def update
    respond_to do |format|
      if @admin_offer.update(admins_offer_params)
        format.html { redirect_to edit_admin_offer_path(@admin_offer), notice: 'Admin offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_offer }
      else
        format.html { render :edit }
        format.json { render json: @admin_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_offers/1
  # DELETE /admin_offers/1.json
  def destroy
    @admin_offer.destroy
    respond_to do |format|
      format.html { redirect_to admins_offers_url, notice: 'Admin offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_offer
      @admin_offer = Offer.find(params[:id])
    end

    def sameadmin
      if current_admin.id != 1 #1
        if @advert.admin_id != current_admin.id #2
          redirect_to admins_adverts_path, notice: "Das solltest du nicht tun!"
        end #eo2
        return true
      end #eo1
    end

    def user_logout
      if session[:user_id] != nil
        session[:user_id] = nil
        session[:expires_at] = Time.now
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_offer_params
      params.require(:offer).permit(:departurelocal, :departuredate, :departuretime, :destinationlocal, :description, :between_stops, :seek, :active, :rules, :departure_id, :destination_id)
    end
end
