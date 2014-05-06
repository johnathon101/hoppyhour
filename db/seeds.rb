# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Beer is name, brewery, place_id, description, need to add photo_ref
#Place is name address, city, state, zip, rating, need to add desc.lat: 41.265195, lon: -95.989554
#Food is entree, sides, daytime, days, place_idlat: 41.261906, lon: -96.036082
Place.create(name: "The Underwood", address: "4948 Underwood Ave", city:"Omaha", state: "NE", zip: "68132", rating: 5, lat: 41.265195, lon: -95.989554)
Place.create(name: "Brazenhead", address: "140 N 78th St", city:"Omaha", state: "NE", zip: "68133", rating: 3, lat: 41.261906, lon: -96.036082)
Food.create(entree: "Pizza", sides: "BreadSticks", days:["monday", "tuesday", "thursday"], daytime: 2, place_id:1)
Food.create(entree: "Hot Beef", sides: "Mash Potatoes", days:["wednesday", "friday", "sunday"], daytime: 3,place_id:2)
Beer.create(name: "Budweiser", brewery: "Annheiser-Busch", desc: "A Pilsner")
Beer.create(name: "Lucky Bucket Lager", brewery: "Nebraska Brewing Company", desc: "A Lager")
Beer.create(name: "Moopy Bs ChocoPorter", brewery: "Some Brewery", desc: "A Porter")
Beer.create(name: "Blue Paddle", brewery: "New Belgium Brewing Company", desc: "An Ale")
Beer.create(name: "Mickeys", brewery: "Mickeys Brewing Inc.", desc: "A Malt Liquor")
