class BookShelf < ActiveRecord::Base
  has_many :book_categories
  has_many :books
end
