class ArticleCategory < ActiveRecord::Base
  has_many :articles
  scope :sorted, order('position ASC')
end
