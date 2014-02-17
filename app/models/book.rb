# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  CURRENCY_RMB, CURRENCY_USD = 1, 2
  mount_uploader :image, BookUploader
  belongs_to :book_shelf
  scope :sorted, order('featured DESC, available DESC, created_at DESC')
  scope :available, where(available: true)

  searchable do
    text :name, :author, :description
  end
end
