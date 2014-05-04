class Place < ActiveRecord::Base
  attr_accessible :address, :city, :name, :rating, :state, :zip
  has_many :foods
  has_many :beers
  accepts_nested_attributes_for :beers, :foods

end
