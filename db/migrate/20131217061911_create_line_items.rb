# -*- encoding : utf-8 -*-
class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order, :null => false
      t.references :book, :null => false
      t.decimal :price, :precision => 7, :scale => 2
      t.integer :amount, :null => false
      t.timestamps
    end
  end
end
