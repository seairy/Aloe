# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  scope :sorted, order('featured DESC')
  validates :name, presence: true, length: { maximum: 100 }
  validates :url, presence: true, length: { maximum: 100 }
end
