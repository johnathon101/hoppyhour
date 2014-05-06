class AddDescToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :desc, :text
  end
end
