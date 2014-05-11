class PlacesController < ApplicationController

  before_filter :admin?, :only => [:edit, :update, :destroy]
  def index
    @places = Place.all.sort_by &:name
    if params["brewdb_id"]
      session["brewdb_id"] = params["brewdb_id"]
      session["beer_name"] = params["beer_name"]
    elsif params["beer_id"]
      session[:beer_id] = params["beer_id"]
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  def show
    @place = Place.find(params[:id])
    if session[:beer_id]!= nil
      add_beer = Beer.find(session[:beer_id])
      begin
        @place.beers.find(add_beer.id)
      rescue ActiveRecord::RecordNotFound
        @place.beers << add_beer
        clear_session
        flash[:notice] = "Beer Successfully Added!"
      rescue ActiveRecord::RecordNotUnique
        flash[:notice] = "Duplicate Entry!"
        clear_session
      end
    end

    @beers = @place.beers.all.sort_by &:name
    @foods = @place.foods.all

    respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @place }
    end
  end

  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place = Place.find(Place.check_and_create(params))
    clear_session
    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Successfully  to Hoppy Hour!.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def results
    @location = Place.search_google(params)
  end

  def workhang_place
    #["lat", 41.259784], ["lon", -96.179262]

    in_latitude = params[:lat].gsub("e", ".")
    in_longitude = params[:lon].gsub("e", ".")
    @place=Place.where(:lat => in_latitude, :lon => in_longitude).first


    respond_to do |format|
      if @place
        format.json { render :json => {:food => @place.foods, :beer => @place.beers }}.to_json
      else
        render json: {message: 'Resource not found'}, status: 404
      end
    end
  end

  def motd
    @beers= Beer.where(:photo_ref != nil, :limit =>10)
  end

end
