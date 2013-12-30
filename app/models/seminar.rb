# -*- encoding : utf-8 -*-
class Seminar < ActiveRecord::Base
  belongs_to :newsletter
  has_many :articles, class_name: 'SeminarArticle'
  has_many :thesis_categories, class_name: 'SeminarThesisCategory'
  has_many :photographs, class_name: 'SeminarPhotograph'
  has_many :videos, class_name: 'SeminarVideo'
  scope :sorted, order('position ASC')
end
