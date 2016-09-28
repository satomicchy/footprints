class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.float :latitude
      t.float :longitude
      t.string :url
      t.string :id_str
      t.references :user

      t.timestamps
    end
    add_index :photos, :user_id
  end
end
