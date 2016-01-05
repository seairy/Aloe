class Emaillist < ActiveRecord::Base
  has_many :recipients, class_name: 'EmaillistRecipient'
  scope :sorted, -> { order('created_at DESC') }
end
