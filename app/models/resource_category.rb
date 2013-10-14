class ResourceCategory < ActiveRecord::Base
  has_many :resources
  scope :sorted, order('position ASC')
end
