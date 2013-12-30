# -*- encoding : utf-8 -*-
class CreateBookCategories < ActiveRecord::Migration
  def change
    create_table :book_categories do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :name, :limit => 200, :null => false
      t.timestamps
    end
  end
end
