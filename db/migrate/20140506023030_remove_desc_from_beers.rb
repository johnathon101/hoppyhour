class RemoveDescFromBeers < ActiveRecord::Migration
  def up
    remove_column :beers, :desc
  end

  def down
    add_column :beers, :desc, :string
  end
end
