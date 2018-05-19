# frozen_string_literal: true

class Article < ActiveRecord::Base
  belongs_to :user
  has_many :favorites
  has_many :taggings
  has_many :tags, through: :taggings
  serialize :tag_list

  def self.author_by(author)
    joins(:user).where('name like ?', "%#{author.strip}%")
  end

  def self.favorited_by(username)
    joins(:favorites).where(favorites: { user: User.where(name: username.strip) })
  end

  def self.tag_with(text)
    tag = Tag.find_by(name: text.strip)
    tag.present? ? tag.articles : []
  end
end
