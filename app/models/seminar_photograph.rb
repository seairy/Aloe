# -*- encoding : utf-8 -*-
class SeminarPhotograph < ActiveRecord::Base
  mount_uploader :image, SeminarPhotographUploader
  belongs_to :seminar
end
