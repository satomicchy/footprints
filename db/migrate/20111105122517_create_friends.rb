class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :prefecture
      t.string :twitter
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
