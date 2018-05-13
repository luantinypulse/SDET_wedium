class Article < ActiveRecord::Base
  belongs_to :author
  serialize :tag_list
end
