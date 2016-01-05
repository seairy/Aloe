# -*- encoding : utf-8 -*-
class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book
end
