# -*- encoding : utf-8 -*-
class PublicationCategory < ActiveRecord::Base
  belongs_to :volume, class_name: 'PublicationVolume'
  has_many :articles, class_name: 'PublicationArticle', foreign_key: :category_id
  scope :sorted, order('volume DESC')
  scope :for_volume, lambda {|volume| where(volume: volume)}
  scope :volumes, group('volume').order('volume DESC')
end
