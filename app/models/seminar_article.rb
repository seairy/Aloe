# -*- encoding : utf-8 -*-
class SeminarArticle < ActiveRecord::Base
  belongs_to :seminar
  scope :sorted, order('featured DESC, visible DESC, created_at DESC')
  scope :visible, where(visible: true)
end
