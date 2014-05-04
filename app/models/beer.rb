class Beer < ActiveRecord::Base
  attr_accessible :brewery, :desc, :name, :place_id
  belongs_to :places
  # Public: Retrieve JSON response from BrewDB and display it for the user.
  #
  # beer - params[:query] - user input.
  # search_query - user input stripped of incooperative characters.
  # beer_search - JSON response from search_query request
  #
  # Examples
  #
  #   Beer.find_beer(params)
  #   # => 'Andry Orchard, Orchard Red, Orchard Blue'
  #
  # Returns all objects from the JSON request
  def self.brewdb_beer(params)
    beer = params[:brewdb_query]
    search_query = (beer).downcase.strip.gsub(' ','+')
    #Send search query to google to find the location(Validate Location)
    beer_search = JSON.load(open("http://api.brewerydb.com/v2/search/?key=#{ENV["BREWDB_KEY"]}&q=#{search_query}&type=beer"))
    return beer_search
  end
  
  # Public: Add user selected beer to the database
  #
  # place - params[:place_id]  - The location from the results page where the beverage is served.
  # @beer - new beer object to be saved into the database after assigning the name and place_id to it.
  #
  # Examples
  #
  #   self.create_beer(place_id, name)
  # => adds object to database
  #   # => place_id
  #
  # Returns place id so user can be rerouted after object has beeen saved.
  def self.create_beer(params)
    place = params[:place_id]
    @beer = Beer.new
    @beer.place_id = place
    @beer.name = params[:name]
    @beer.save
    return place
  end
  
  # Public: Search the database for a user supplied query from the header.
  #
  # query - params[:q]  - The String from the user to be queried to the db
  # length - An arbitrary amount of text to be searched from the db, manual fuzzy search
  # term - Take the second letter to the length amount of text to search for, more manual fuzzy search.
  #
  # Examples
  #
  #   find_beer(params[:q] = "Orchard")
  #   # => 'Angry Orchard' , 'Blue Orchard'
  #
  # Returns Beer objects where the beer.name attribute contains the term serached for after manual fuzzy alterations.
  def self.search_beer(params)
    query = params[:beer_query].downcase 
    length=1+(query.size)/3
    term=query[1..length]
    return Beer.where("name like ?", "%#{term}%")
  end
end
