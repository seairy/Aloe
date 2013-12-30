# -*- encoding : utf-8 -*-
class PublicationArticle < ActiveRecord::Base
  belongs_to :category, class_name: 'PublicationCategory'
  scope :sorted, order('updated_at DESC')
end
