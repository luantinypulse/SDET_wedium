json.articles_count @articles.size

# json.articles(@articles, :title, :slug, :body, :tag_list, :created_at, :updated_at,
#     :description, :favorited, :favorites_count, :author)

# json.articles @articles do |article|
#     json.title article.title
#     json.slug article.slug
#     json.body article.body
#     json.createdAt article.created_at
#     json.updatedAt article.updated_at
#     json.tagList article.tag_list
#     json.description article.description
#     json.favorited article.favorited
#     json.favorites_count article.favorites_count
#     json.author article.author, :name, :bio, :image, :following
# end

json.articles @articles do |article|
    json.(article, :title, :slug, :body, :tag_list, :created_at, :updated_at, :description)
    json.author article.author, :name, :bio, :image, :following
    json.(article, :favorited, :favorites_count)
end