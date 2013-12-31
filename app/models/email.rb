# -*- encoding : utf-8 -*-
class Email < ActiveRecord::Base
  RECIPIENTS_TYPE_ALL, RECIPIENTS_TYPE_PERMANENT, RECIPIENTS_TYPE_COUNCIL_MEMBER = 'all', 'permanent', 'council_member'
  scope :sent, where(sent: true)
  scope :unsent, where(sent: false)
  
  class << self
    def bulk_create recipients_type, subject, content
      recipients = case recipients_type
      when RECIPIENTS_TYPE_ALL then Member.approved.map{|m| m.recipients.subscribed.all}
      end
      recipients.flatten.each do |r|
        self.create({ recipient: r.name, subject: subject, content: content })
      end
    end
  end
end
