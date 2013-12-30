# -*- encoding : utf-8 -*-
class PublicationVolume < ActiveRecord::Base
  mount_uploader :image, PublicationVolumeUploader
  belongs_to :publication
  has_many :categories, class_name: 'PublicationCategory', foreign_key: :volume_id
  scope :sorted_by_name, order('featured DESC, name DESC')
  scope :sorted_by_time, order('featured DESC, created_at DESC')
  scope :featured, where(featured: true)
end
