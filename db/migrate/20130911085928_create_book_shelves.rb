class CreateBookShelves < ActiveRecord::Migration
  def change
    create_table :book_shelves do |t|
      t.references :book_category, :null => false
      t.references :book, :null => false
      t.timestamps
    end
  end
end
