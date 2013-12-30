# -*- encoding : utf-8 -*-
class Forum < ActiveRecord::Base
  has_many :topics
  scope :sorted, order('position ASC')
end
