# -*- encoding : utf-8 -*-
class Poster < ActiveRecord::Base
  mount_uploader :image, PosterUploader
  attr_accessor :related_article_id
  scope :sorted, order('available ASC, position ASC, created_at DESC')
  scope :available, where(available: true)
end
