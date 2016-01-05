# -*- encoding : utf-8 -*-
class Payment < ActiveRecord::Base
  belongs_to :member
  scope :revenue, where(revenue: true)
  scope :grant, where(revenue: false)

end
