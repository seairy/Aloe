# -*- encoding : utf-8 -*-
class Member < ActiveRecord::Base
  belongs_to :country
  has_many :contacts
  has_many :recipients
  has_many :payments
  has_many :orders
  scope :sorted, order('joined_at DESC')
  scope :approved, where(approved: true)
  scope :permanent, where(permanent: true)
  scope :signin, lambda {|account, password| where(account: account, hashed_password: Digest::MD5.hexdigest(password), approved: true)}
  scope :duplicated, group('account').having('count(id) > 1')
  scope :domestic, where('country_id IN (100056, 100058, 100072, 100077)')
  scope :foreign, where('country_id NOT IN (100056, 100058, 100072, 100077)')
  validates :chinese_name, presence: true, length: { maximum: 50 }
  
  def individual?
    self.type == 'IndividualMember'
  end
  
  def organization?
    self.type == 'OrganizationMember'
  end
  
  def quota
    self.individual? ? 200 : (self.profit? ? 5000 : 500)
  end
  
  def pay year, remark
    before_expired_at = self.expired_at
    self.balance += self.quota * year
    self.expired_at = Date.today if self.expired_at <= Date.today
    self.expired_at += year.year
    self.save
    Payment.create(member: self, revenue: true, amount: self.quota * year.to_i, paid_at: Time.now, before_expired_at: before_expired_at, extended_to: self.expired_at, remark: remark)
  end
end
