class UsersAddFieldsAboutTwitterPost < ActiveRecord::Migration
  def up
    change_table(:users, :bulk => true) do |t|
      t.string :twitter_token
      t.string :twitter_secret
    end
  end

  def down
    change_table(:users, :bulk => true) do |t|
      t.remove :twitter_token
      t.remove :twitter_secret
    end
  end
end
