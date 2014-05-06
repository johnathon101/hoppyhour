class BeersController < ApplicationController
  # GET /beers
  # GET /beers.json
  def index
    @place =Place.find(params[:place_id])
    @beers = @place.beers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beers }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show

    @beer = Beer.find(params[:id])
    @places = @beer.places.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @place = Place.find(params[:place_id])
    @beer = Beer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:id])
  end

  # POST /beers
  # POST /beers.json
  def create
    @place = Place.find(params[:place_id])
    #We get the beer id from the params, or the last time the user searched brew db and clicked to add the user.

    beer_id = session[:brewdb_id] || params[:brew_id]
    @beer = Beer.where(:brewdb_id => beer_id).first
    check_db = @place.beers.where(:id => @beer.id).first
    if @beer != nil && check_db == nil
      @place.beers << @beer
      clear_session
      redirect_to place_path(@place.id) and return
    elsif @beer != nil && check_db != nil
      redirect_to place_path(@place.id) and return
    else
      response = JSON.load(open("http://api.brewerydb.com/v2/beer/#{beer_id}?key=#{ENV["BREWDB_KEY"]}&withBreweries=Y"))
      a        = response["data"]
      name     = a["name"]
      brewdb_id = beer_id
      photo_ref = a["labels"]["medium"]
      abv       = a["abv"]
      ibu       = a["ibu"]
      brewery   = a["breweries"][0]["name"]
      desc      = a["style"]["description"]
      add_beer  = {name: name, abv: abv, ibu: ibu, brewery: brewery, desc: desc, brewdb_id: beer_id, photo_ref: photo_ref }
      @beer     = @place.beers.create(add_beer)
    end
    clear_session

    respond_to do |format|
      if @beer.save
        format.html { redirect_to place_path(@place.id), notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:id])

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to place_path(@place.id) }
      format.json { head :no_content }
    end
  end
  #Page of returned results for a specific beer.
  def results
    @beer_search = Beer.brewdb_beer(params)
  end
  #Local Search for beers in the DB already allocated to a Place.
  def search
    @hits = Beer.search_beer(params)
  end

  def complete_index
    @beers = Beer.all
  end

end
