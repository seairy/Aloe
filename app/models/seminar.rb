class Seminar < ActiveRecord::Base
  belongs_to :newsletter
  scope :sorted, order('position ASC')
end
