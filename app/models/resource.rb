# -*- encoding : utf-8 -*-
class Resource < ActiveRecord::Base
  MEDIA_TYPE_AUDIO, MEDIA_TYPE_VIDEO, MEDIA_TYPE_ANIMATION = 1, 2, 3
  mount_uploader :image, ResourceImageUploader
  mount_uploader :media, ResourceMediaUploader
  belongs_to :category, class_name: 'ResourceCategory'
  scope :sorted, order('visible DESC, featured DESC, created_at DESC')
  scope :latest, order('featured DESC, displayed_at DESC')
  scope :visible, where(visible: true)
end
