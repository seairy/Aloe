class Thesis < ActiveRecord::Base
  mount_uploader :image, ThesisUploader
  scope :sorted, order('featured DESC, created_at DESC')
end
