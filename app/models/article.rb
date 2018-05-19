class Article < ActiveRecord::Base
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  serialize :tag_list

  def self.author_by(author)
    @articles = Article
                  .joins(:user)
                  .where('name like ?', "%#{author}%")
  end

  def self.favorited_by(username)
    user = User.find_by(name: username)
    if user.nil? 
      return []
    end
    article_ids = Favorite.where(user_id: user.id).pluck(:article_id)
    @articles = Article.where(id: article_ids)
  end

  def self.tag_with(text)
    tag = Tag.find_by(name: text)
    tag.present? ? @articles=tag.articles : [] 
  end
end
