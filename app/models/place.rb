class Place < ActiveRecord::Base
  attr_accessible :address, :city, :name, :rating, :state, :zip
  has_many :foods
  has_and_belongs_to_many :beers
  accepts_nested_attributes_for :beers, :foods
  after_commit :delete_place_cache

  def self.duplicate?(name)
    @place = Place.find_by_name(name)
    if @place
      return @place.id
    else
      return false
    end
  end

  def self.add_place(name, address, lat, lon)
    new_place = Place.create({name: name, address: address, lat: lat, lon: lon})
    return new_place.id
  end

  def self.search_google(params)
    @place = params[:query]
    search_query=(@place).downcase.strip.gsub(' ','+')
    #Send search query to google to find the location(Validate Location)
    @val_loc = JSON.load(open("https://maps.googleapis.com/maps/api/place/textsearch/json?key=#{ENV["GOOGLE_API_KEY"]}&location=41.2918589,-96.0812485&radius=5000&query=#{search_query}&sensor=false"))
    return @val_loc
  end

  #CACHING METHOD
  def place_name
    Rails.cache.fetch([self, "place_name"]) {self.place_name}
  end

  def self.place_information
    Rails.cache.fetch("all_places") {self.all}
  end

  def delete_place_cache
    Rails.cache.delete(["all_places", Place.all])
  end

  def self.check_and_create(params)

    lat=params[:lat].gsub("e",".").to_f
    lng=params[:lon].gsub("e",".").to_f

    @check_db=Place.where({:lat=>lat, :lon=>lng}).first

    #If place is in db go to that page
    if @check_db != nil
      @location_id = @check_db.id
    else
      #If the location is not in HoppyHour yet, we can add it.
      address = params[:address].split(',')
      @place=Place.new
      @place.name = params[:name]
      @place.address = address[0]
      @place.city = address[1]
      @place.state = address[2]
      @place.lon=lng
      @place.lat=lat
      @place.save
      @location_id = @place.id
    end
    return @location_id
  end
end
