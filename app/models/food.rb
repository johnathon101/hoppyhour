class Food < ActiveRecord::Base
  attr_accessible :days, :daytime, :entree, :place_id, :sides, :price
  belongs_to :places
  serialize :days, Array
end
