class Article < ActiveRecord::Base
  belongs_to :category, class_name: 'ArticleCategory'
  scope :sorted, order('featured DESC, visible DESC, created_at DESC')
  scope :latest, order('created_at DESC')
  scope :visible, where(visible: true)
end
