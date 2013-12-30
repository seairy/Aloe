# -*- encoding : utf-8 -*-
class SeminarThesis < ActiveRecord::Base
  belongs_to :category, class_name: 'SeminarThesisCategory'
end
