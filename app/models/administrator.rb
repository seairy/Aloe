# -*- encoding : utf-8 -*-
class Administrator < ActiveRecord::Base
  belongs_to :role
  has_many :notifications
  has_secure_password
  validates :role, presence: true
  validates :account, presence: true, length: { maximum: 32 }
  validates :password, presence: true, length: { maximum: 50 }, :on => :create
  validates :name, presence: true, length: { maximum: 5 }
end
