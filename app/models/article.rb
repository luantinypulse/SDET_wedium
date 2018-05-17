class Article < ActiveRecord::Base
  belongs_to :user
  serialize :tag_list

  def self.author_json
    author = self.article.author
    render json: author.as_json(include:[:name])
  end
end
