# -*- encoding : utf-8 -*-
class Publication < ActiveRecord::Base
  has_many :volumes, class_name: 'PublicationVolume'

  class << self
    def owned
      self.where(name: '世界汉语教学')
    end
  end
end
