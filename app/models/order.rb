class Order < ActiveRecord::Base
  StatusSubmited, StatusProcessing, StatusInTransit, StatusFinished = 1, 2, 3, 4
  belongs_to :member
  has_many :line_items
end
