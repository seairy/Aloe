# -*- encoding : utf-8 -*-
class Email < ActiveRecord::Base
  RECIPIENTS_TYPE_ALL,
  RECIPIENTS_TYPE_PERMANENT,
  RECIPIENTS_TYPE_COUNCIL_MEMBER,
  RECIPIENTS_TYPE_EMAILLIST,
  RECIPIENTS_TYPE_MEMBER = 'all', 'permanent', 'council_member', 'emaillist', 'member'
  scope :sent, where(sent: true)
  scope :unsent, where(sent: false)

  def sent!
    self.update_attribute :sent, true
    self.update_attribute :sent_at, Time.now
  end
  
  class << self
    def bulk_create recipients_type, recipients_value, subject, content
      recipients = case recipients_type
      when RECIPIENTS_TYPE_ALL then Member.approved.map{|m| m.recipients.subscribed.all}
      when RECIPIENTS_TYPE_PERMANENT then Member.approved.permanent.map{|m| m.recipients.subscribed.all}
      when RECIPIENTS_TYPE_EMAILLIST then Emaillist.find(recipients_value).recipients.available
      when RECIPIENTS_TYPE_MEMBER then Member.find(recipients_value).recipients.subscribed.all
      end || []
      recipients.flatten.each do |r|
        self.create({ recipient: r.name, subject: subject, content: content })
      end
    end
  end
end
