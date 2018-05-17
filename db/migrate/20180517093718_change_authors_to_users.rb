class ChangeAuthorsToUsers < ActiveRecord::Migration
  def change
    rename_table :authors, :users
  end
end
