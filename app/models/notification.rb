# -*- encoding : utf-8 -*-
class Notification < ActiveRecord::Base
  belongs_to :administrator
  scope :for_administrator, lambda {|administrator_id| where(administrator_id: administrator_id)}
  scope :unread, where(read: false)
  scope :read, where(read: true)
  scope :sorted, order('`read` ASC, created_at DESC')
  
  def read!
    self.update_attribute :read, true unless self.read?
  end
end
