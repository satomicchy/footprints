class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :events, :latitude, :float
    change_column :events, :longitude, :float
  end
end
