class FoodsController < ApplicationController
  # GET /foods
  # GET /foods.json
  def index
    @place = Place.find(params[:place_id])
    @foods = @place.foods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/new
  # GET /foods/new.json
  def new
    @place = Place.find(params[:place_id])
    @food = Food.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/1/edit
  def edit
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])
  end

  # POST /foods
  # POST /foods.json
  def create
    @place = Place.find(params[:place_id])
    @food = @place.foods.build(params[:food])

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foods/1
  # PUT /foods/1.json
  def update
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])

    respond_to do |format|
      if @food.update_attributes(params[:food])
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end
end
