# -*- encoding : utf-8 -*-
class Continent < ActiveRecord::Base
  has_many :countries
end
