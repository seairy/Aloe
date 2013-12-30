# -*- encoding : utf-8 -*-
class ArticleCategory < ActiveRecord::Base
  has_many :articles, foreign_key: :category_id
  scope :sorted, order('position ASC')
end
