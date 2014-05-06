class AddIbuabvToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :ibu, :float
    add_column :beers, :abv, :float
  end
end
