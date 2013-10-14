class Poster < ActiveRecord::Base
  mount_uploader :image, PosterUploader
  attr_accessor :related_article_id
  scope :sorted, order('available ASC, created_at DESC')
end
