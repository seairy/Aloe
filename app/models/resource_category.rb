# -*- encoding : utf-8 -*-
class ResourceCategory < ActiveRecord::Base
  has_many :resources, foreign_key: :category_id
  scope :sorted, order('position ASC')
end
