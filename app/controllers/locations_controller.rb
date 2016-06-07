class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index

    @locations = Location.all
      

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    
    @weather = ForecastIO.forecast(@location.latitude, @location.longitude)
    @current_weather = @weather['currently']
    @forecast = @weather['daily']['data']

    #Historic Data

    @historic_value = []

    @time_now = Time.now
    @year = @time_now.year
    @month = @time_now.month
    

    # @temporal  = (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year , @month, @time_now.day).to_i))["currently"]["temperature"]


    # Last Five years
    @historic_value << (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year , @month, @time_now.day).to_i))["currently"]["temperature"]
    # @historic_value << (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year -1 , @month, @time_now.day).to_i))["currently"]["temperature"]
    # @historic_value << (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year -2, @month, @time_now.day).to_i))["currently"]["temperature"]
    # @historic_value << (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year -3, @month, @time_now.day).to_i))["currently"]["temperature"]
    # @historic_value << (ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year -4, @month, @time_now.day).to_i))["currently"]["temperature"]



  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end
end
