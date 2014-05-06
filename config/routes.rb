Hoppyhour2::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :places do
    resources :foods
    resources :beers
  end


  resources :users
  resources :sessions
  root :to =>  "places#index"
  get "/beer_search"=> "beers#search", :as => "beer_search"
  get "/food_search"=> "foods#search", :as => "food_search"
  post "/beers/results" =>"beers#results", :as => "beers_results"
  post "/places/results" => "places#results", :as => "places_results"
  get "/foods/all" => "foods#complete_index", :as => "foods_index"
  get "/beers/all" => "beers#complete_index", :as => "beers_index"
  #JSON Response for Workhang
  get "/workhang/:lat/:lon" => "places#workhang_place", defaults: {format: :json}
  post "/add_beer" => "beers#create", :as => "add_beer"
  get "/beers/:id" => "beers#show", :as => "show_beer"

end
