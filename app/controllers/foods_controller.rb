class FoodsController < ApplicationController

  def index
    @place = Place.find(params[:place_id])
    @foods = @place.foods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  def show
    @food = Food.find(params[:id])
    @place = Place.find(params[:place_id])
    @time = ["Breakfast", "Lunch", "Dinner"]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  def new
    @place = Place.find(params[:place_id])
    @days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @food = Food.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  def edit
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])
    @time = ["Breakfast", "Lunch", "Dinner"]
    @days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def create
    @place = Place.find(params[:place_id])
    @food = @place.foods.build(params[:food])
    @food.days = (params["day"]["days"]).reject! { |e| e.empty? }
    respond_to do |format|
      if @food.save
        format.html { redirect_to place_path(@place.id), notice: 'Food was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @place = Place.find(params[:place_id])
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end

  def complete_index
    @foods = Food.all
  end
end
