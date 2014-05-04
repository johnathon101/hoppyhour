class Beer < ActiveRecord::Base
  attr_accessible :brewery, :desc, :name, :place_id
  belongs_to :places
end
