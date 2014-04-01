# -*- encoding : utf-8 -*-
class Newsletter < ActiveRecord::Base
  mount_uploader :image, NewsletterUploader
  scope :sorted, order('created_at DESC')
end
