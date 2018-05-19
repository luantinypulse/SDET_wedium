# frozen_string_literal: true

json.articles_count @articles.size
json.articles @articles do |article|
  json.call(article, :id, :title, :slug, :body, :tag_list, :created_at, :updated_at, :description)
  json.author article.user, :id, :name, :bio, :image, :following
  json.call(article, :favorited, :favorites_count)
  json.tags article.tags.map(&:name).join(', ')
end
