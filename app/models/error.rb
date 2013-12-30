# -*- encoding : utf-8 -*-
class Error < ActiveRecord::Base
  belongs_to :administrator
  scope :sorted, order('created_at DESC')
end
