class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.float :latitude
      t.float :longitude
      t.string :url
      t.integer :status, :default => 0
      t.references :user

      t.timestamps
    end
    add_index :photos, [:user_id, :status]
  end
end
