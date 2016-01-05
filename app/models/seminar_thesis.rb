# -*- encoding : utf-8 -*-
class SeminarThesis < ActiveRecord::Base
  mount_uploader :document, SeminarThesisUploader
  belongs_to :category, class_name: 'SeminarThesisCategory'
end
