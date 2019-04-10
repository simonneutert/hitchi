class Admins::SeeksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin_seek, only: [:show, :edit, :update, :destroy]
  before_action :sameadmin, only: [:show, :edit, :update, :destroy]
  before_action :user_logout

  # GET /admin_seeks
  # GET /admin_seeks.json
  def index
    @admin_seeks = Offer.where(active: true, seek: true)
  end

  # GET /admin_seeks/1
  # GET /admin_seeks/1.json
  def show
  end

  # GET /admin_seeks/new
  def new
    #@admin_seek = AdminSeek.new
  end

  # GET /admin_seeks/1/edit
  def edit
  end

  # POST /admin_seeks
  # POST /admin_seeks.json
  def create
  #   @admin_seek = AdminSeek.new(admin_seek_params)
  #
  #   respond_to do |format|
  #     if @admin_seek.save
  #       format.html { redirect_to @admin_seek, notice: 'Admin seek was successfully created.' }
  #       format.json { render :show, status: :created, location: @admin_seek }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @admin_seek.errors, status: :unprocessable_entity }
  #     end
  #   end
  end

  # PATCH/PUT /admin_seeks/1
  # PATCH/PUT /admin_seeks/1.json
  def update
    respond_to do |format|
      if @admin_seek.update(admin_seek_params)
        format.html { redirect_to @admin_seek, notice: 'Admin seek was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_seek }
      else
        format.html { render :edit }
        format.json { render json: @admin_seek.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_seeks/1
  # DELETE /admin_seeks/1.json
  def destroy
    @admin_seek.destroy
    respond_to do |format|
      format.html { redirect_to admin_seeks_url, notice: 'Admin seek was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_seek
      @admin_seek = AdminSeek.find(params[:id])
    end

    def user_logout
      if session[:user_id] != nil
        session[:user_id] = nil
        session[:expires_at] = Time.now
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_seek_params
      params.require(:offer).permit(:departurelocal, :departuredate, :departuretime, :destinationlocal, :description, :between_stops, :seek, :active, :rules, :departure_id, :destination_id)
    end
end
