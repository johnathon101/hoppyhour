Hoppyhour --
Our first solo project at Omaha Code School.
Hoppyhour is a rails application to organize local food and beverage specials.
Currently in it's second stage HoppyHour uses BrewDB to find beers in order
to be added to places which are found via Google Places API. The database is
able to be queried for a specific food or beer and places that serve the desired
item are returned to the user. Further Hoppyhour is setup to relay a JSON response
to workhang.com that will allow it to also display food and beverage specials
at places that are mutual between the two sites. Hoppyhour is entirely user powered
so the accurate data is a premium. Future enhancements include either a JSON
parse or html scrape off of an aggregator site at least until the database begins
to populate further.
Hoppyhour is built with three css media queries ranges to scale for many devices.
  - Improvement over beta, .. no css responsiveness
BrewDB is now integrated into adding beer into a place.
  - Initial version only used name and was not as informative.
  - Currently Name, Brewery, Description, ABV, IBU are being stored.
Place is now storing lon/lat data to provide like queries for WorkHang.
  - JSON response to WorkHang will allow specials to be shared accross sites.
  - Hopefully will foster more interest in evaluating work options.
Nested Resource Routing
  - Places show path is now the root path which will allow better show pages and
  user experience as the data continues to grow.

Future Enhancements :
  - Use jQuery to show/hide more data.
  - Create UI for sidebar menu for full view & smaller resolutions
  - Streamline food editing so many can be added/edited at once
  - Before_filter controllers so only logged in users can change place details
  - Find local sites that have updated lists of place specials and see if they
  can be integrated to display automatically on HoppyHour
  - Improve Beer show page to give more information/images on beers that are
  already in the DB.
  - Make animations/parallax effects to make the site flash more.

WorkHang integration coming soon, JSON response is working but the show views on
http://workhang.com must be updated.
@johnathon102
