# -*- encoding : utf-8 -*-
class Newsletter < ActiveRecord::Base
  mount_uploader :image, NewsletterUploader
  scope :sorted, order('position ASC')
end
