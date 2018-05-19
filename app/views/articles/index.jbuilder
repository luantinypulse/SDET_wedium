json.articles_count @articles.size
json.articles @articles do |article|
    json.(article, :id, :title, :slug, :body, :tag_list, :created_at, :updated_at, :description)
    json.author article.user, :id, :name, :bio, :image, :following
    json.(article, :favorited, :favorites_count)
    json.tags article.tags.map(&:name).join(', ')
end