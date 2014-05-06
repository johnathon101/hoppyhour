class AddPhotorefBrewdbidToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :photo_ref, :text
    add_column :beers, :brewdb_id, :string
  end
end
