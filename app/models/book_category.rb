# -*- encoding : utf-8 -*-
class BookCategory < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :book_shelf
end
