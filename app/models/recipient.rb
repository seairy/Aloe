# -*- encoding : utf-8 -*-
class Recipient < ActiveRecord::Base
  belongs_to :member
  scope :available, where(available: true)
  scope :subscribed, where(subscribed: true)
  scope :duplicated, group('name').having('count(id) > 1')
  validates :name, presence: true, length: { maximum: 50 }, email_format: { message: '不是有效的' }
  searchable do
    text :name
  end
  
  class << self
    def cleanable? name
      recipients = self.where(name: name)
      if recipients.count > 1
        recipients.map{|r| r.member_id}.uniq.count < recipients.count ? true : false
      else
        false
      end
    end
    
    def clean_duplicated!
      self.duplicated.count.each do |duplicated_recipient|
        self.where(name: duplicated_recipient[0]).each do |recipient|
          recipient.destroy if self.where(name: recipient.name, member_id: recipient.member_id).where('id != ?', recipient.id).first
        end
      end
    end
  end
end
