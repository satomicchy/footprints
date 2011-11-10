class ChangeColumnTypeFriend < ActiveRecord::Migration
  def change
    change_column :friends, :latitude, :float
    change_column :friends, :longitude, :float
  end
end
