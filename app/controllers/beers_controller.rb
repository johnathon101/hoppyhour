class BeersController < ApplicationController
  before_filter :admin?, :only => [:edit, :update, :destroy]

  def index
    @place =Place.find(params[:place_id])
    @beers = @place.beers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beers }
    end
  end

  def show

    @beer = Beer.find(params[:id])
    @places = @beer.places.all

    respond_to do |format|
      if params[:iframe] == "true"
        format.html {render layout: "beer_box"}# show.html.erb
        format.json { render json: @place, :layout => false }
      else
        format.html # show.html.erb
        format.json { render json: @beer }
      end
    end
  end

  def new
    @place = Place.find(params[:place_id])
    @beer = Beer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  def edit
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:id])
  end

  def create
    @place = Place.find(params[:place_id])
    #We get the beer id from the params, or the last time the user searched brew db and clicked to add the user.

    beer_id = session[:brewdb_id] || params[:brew_id]
    @beer = Beer.where(:brewdb_id => beer_id).first
    photo_ref = Array.new
    if @beer != nil
      check_db = @place.beers.where(:id => @beer.id).first
        if check_db == nil
          @place.beers << @beer
        elsif check_db != nil
          check_db = @place.beers.where(:id => @beer.id)
        end
      clear_session
      redirect_to place_path(@place.id) and return
    else
      response = JSON.load(open("http://api.brewerydb.com/v2/beer/#{beer_id}?key=#{ENV["BREWDB_KEY"]}&withBreweries=Y"))

      a        = response["data"]
      name     = a["name"]
      brewdb_id = beer_id
      a["labels"].present? ? photo_ref = a["labels"]["medium"] : photo_ref = nil
      abv       = a["abv"] || ""
      ibu       = a["ibu"] || ""
      brewery   = a["breweries"][0]["name"] || ""
      desc      = a["style"]["description"] || ""
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

  def destroy
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:beer_id])
    @del_beer = @place.beers.find(@beer.id)
    @del_beer.destroy
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
