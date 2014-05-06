class RemovePlaceidFromBeers < ActiveRecord::Migration
  def up
    remove_column :beers, :place_id
  end

  def down
    add_column :beers, :place_id, :string
  end
end
