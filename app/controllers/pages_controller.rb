class BeersController < ApplicationController
  def index
    @places = Place.all
    
  end
end