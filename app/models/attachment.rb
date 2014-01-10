class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentUploader
  validates :file, presence: true
end
