# -*- encoding : utf-8 -*-
class Topic < ActiveRecord::Base
  belongs_to :forum
  scope :sorted, order('visible DESC, featured DESC, created_at DESC')
  scope :latest, order('featured DESC, displayed_at DESC')
  scope :visible, where(visible: true)
end
