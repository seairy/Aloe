# -*- encoding : utf-8 -*-
class Contact < ActiveRecord::Base
  GenderUnknown, GenderMale, GenderFemale = 0, 1, 2
  belongs_to :member
  validates :name, length: { maximum: 50 }, on: :update
  validates :title, length: { maximum: 50 }, on: :update
  validates :phone, length: { maximum: 50 }, on: :update
  validates :mobile, length: { maximum: 50 }, on: :update
  validates :fax, length: { maximum: 50 }, on: :update
end
