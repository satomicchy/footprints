class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.date :organize_at
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
