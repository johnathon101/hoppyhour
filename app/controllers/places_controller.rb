class PlacesController < ApplicationController
  # GET /places
  # GET /places.json

  def index
    @places = Place.all
    if params["brewdb_id"]
      session["brewdb_id"] = params["brewdb_id"]
      session["beer_name"] = params["beer_name"]
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.find(Place.check_and_create(params))

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
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

  # DELETE /places/1
  # DELETE /places/1.json
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

end
