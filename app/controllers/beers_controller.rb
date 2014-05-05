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
    @place = Place.find(params[:place_id])
    @beer = Beer.find(params[:id])

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
    @beer = @place.beers.build(params[:beer])
    respond_to do |format|
      if @beer.save
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
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
    @company = Company.find(parmas[:company_id])
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
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
