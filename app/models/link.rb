# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  scope :sorted, order('featured DESC')
end
