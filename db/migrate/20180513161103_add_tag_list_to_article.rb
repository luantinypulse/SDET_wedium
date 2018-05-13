class AddTagListToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :tag_list, :string, array: true, default: []
  end
end
