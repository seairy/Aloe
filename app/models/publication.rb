# -*- encoding : utf-8 -*-
class Publication < ActiveRecord::Base
  has_many :volumes, class_name: 'PublicationVolume'
end
