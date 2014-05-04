class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :brewery
      t.string :name
      t.string :desc
      t.integer :place_id

      t.timestamps
    end
  end
end
