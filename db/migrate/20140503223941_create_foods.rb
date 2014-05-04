class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :entree
      t.string :sides
      t.integer :daytime
      t.text :days
      t.integer :place_id

      t.timestamps
    end
  end
end
