class AddAuthorToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author_id, :integer, null: false
  end
end
