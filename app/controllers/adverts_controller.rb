class AdvertsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_advert, only: [:show, :edit, :update, :destroy]
  before_action :sameadmin, only: [:show, :edit, :update, :destroy]

  # GET /adverts
  # GET /adverts.json
  def index
    @adverts = Advert.all
  end

  def departurelog
    @departures = Offer.where(active: true).pluck(:departure_id)
    @departures = @departures.uniq
    @departures = Departure.where(id: @departures)
  end
  def destinationlog
    @destinations = Offer.where(active: true).pluck(:destination_id)
    @destinations = @destinations.uniq
    @destinations = Destination.where(id: @destinations)
  end

  # GET /adverts/1
  # GET /adverts/1.json
  def show
  end

  # GET /adverts/new
  def new
    @advert = current_admin.adverts.build()
  end

  # GET /adverts/1/edit
  def edit
  end

  # POST /adverts
  # POST /adverts.json
  def create
    @advert = current_admin.adverts.new(advert_params)
    respond_to do |format|
      if @advert.save
        format.html { redirect_to @advert, notice: 'Advert was successfully created.' }
        format.json { render :show, status: :created, location: @advert }
      else
        format.html { render :new }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adverts/1
  # PATCH/PUT /adverts/1.json
  def update
    respond_to do |format|
      if @advert.update(advert_params)
        format.html { redirect_to @advert, notice: 'Advert was successfully updated.' }
        format.json { render :show, status: :ok, location: @advert }
      else
        format.html { render :edit }
        format.json { render json: @advert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.json
  def destroy
    @advert.destroy
    respond_to do |format|
      format.html { redirect_to adverts_url, notice: 'Advert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advert
      @advert = Advert.find(params[:id])
    end

    def sameadmin
      if current_admin.id != 1 #1
        if @advert.admin_id != current_admin.id #2
          redirect_to adverts_path, notice: "Das solltest du nicht tun!"
        end #eo2
        return true
      end #eo1
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advert_params
      params.require(:advert).permit(:title, :client, :city, :linkurl, :viewcounter, :clickcounter, :begin_ad, :end_ad, advertimage_attributes:[:image, :id, :image_cache, :_destroy])
    end
end
