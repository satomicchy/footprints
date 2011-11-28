class AddcolumnUserid < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    add_column :friends, :user_id, :integer
  end
end
