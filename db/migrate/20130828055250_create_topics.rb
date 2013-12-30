# -*- encoding : utf-8 -*-
class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :forum, :null => false
      t.boolean :original, :null => false
      t.string :title, :limit => 200, :null => false
      t.string :author, :limit => 200
      t.text :content
      t.boolean :visible, :featured, :null => false
      t.integer :views_count, :default => 0, :null => false
      t.datetime :displayed_at, :null => false
      t.timestamps
    end
  end
end
