class JoinTableForBeersPlaces < ActiveRecord::Migration
def up
  create_table :beers_places, :id => false do |t|
    t.references :beer, :null => false
    t.references :place, :null => false
  end

# Adding the index can massively speed up join tables. Don't use the
# unique if you allow duplicates.
  add_index(:beers_places, [:beer_id, :place_id], :unique => true)
end


def down
  drop table :beers_places
end
end
