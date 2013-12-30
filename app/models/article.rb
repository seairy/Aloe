# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  mount_uploader :image, ArticleUploader
  belongs_to :category, class_name: 'ArticleCategory'
  scope :sorted, order('featured DESC, visible DESC, created_at DESC')
  scope :latest, order('created_at DESC')
  scope :imaged, where('image IS NOT NULL')
  scope :nonimage, where('image IS NULL')
  scope :visible, where(visible: true)
  scope :featured, where(featured: true)
end
