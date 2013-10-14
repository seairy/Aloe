class Newsletter < ActiveRecord::Base
  mount_uploader :image, NewsletterUploader
  scope :sorted, order('position ASC')
end
