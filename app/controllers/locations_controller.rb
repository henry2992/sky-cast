class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  respond_to :js, :json, :html

  before_action :authenticate_user!

  # GET /locations
  # GET /locations.json
  def index

    @locations = current_user.locations
    @location = request.location
    @weather = ForecastIO.forecast(@location.latitude, @location.longitude)
    @current_weather = @weather['currently']
      
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    
    @weather = ForecastIO.forecast(@location.latitude, @location.longitude)
    @current_weather = @weather['currently']
    @forecast = @weather['daily']['data']
    
    
  end

  def call

    @location = Location.find( params[:id])


    @historic_value = []
    @historic_years = []

    @time_now = Time.now
    @year = @time_now.year
    @month = @time_now.month
    

    # Last Five years
    # Year one
    y1 = ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year -1 , @month, @time_now.day).to_i)
    @historic_value << y1["currently"]["temperature"]
    @historic_years << @year - 1

    y2 = ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year - 2 , @month, @time_now.day).to_i)
    @historic_value << y2["currently"]["temperature"]
    @historic_years << @year - 2

    y3 = ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year - 3, @month, @time_now.day).to_i)
    @historic_value << y3["currently"]["temperature"]
    @historic_years << @year - 3

    y4 = ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year - 4 , @month, @time_now.day).to_i)
    @historic_value << y4["currently"]["temperature"]
    @historic_years << @year - 4

    y5 = ForecastIO.forecast(@location.latitude, @location.longitude, time: Time.new(@year - 5 , @month, @time_now.day).to_i)
    @historic_value << y5["currently"]["temperature"]
    @historic_years << @year - 5


    render :layout => false
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
    # @location = Location.new(location_params)
    # @location.user_id = current_user.id

    # @location = current_user.locations.create(location_params)
    @location = current_user.locations.new(location_params)


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
      params.require(:location).permit(:postal_code, :latitude, :longitude)
    end

   
end
