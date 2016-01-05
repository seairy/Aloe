# -*- encoding : utf-8 -*-
class SeminarThesisCategory < ActiveRecord::Base
  belongs_to :seminar
  has_many :theses, class_name: 'SeminarThesis', foreign_key: 'category_id'
  scope :sorted, order('position ASC')
end
