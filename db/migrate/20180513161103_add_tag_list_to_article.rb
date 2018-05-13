class AddTagListToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :tag_list, :string, array: true, default: ['Seeding data 1', 'Seeding data 2']
  end
end
