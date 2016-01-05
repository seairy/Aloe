# -*- encoding : utf-8 -*-
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :category, :null => false
      t.string :image, :limit => 500
      t.string :title, :source, :limit => 200
      t.text :content
      t.boolean :visible, :featured, :null => false
      t.integer :views_count, :default => 0, :null => false
      t.datetime :displayed_at, :null => false
      t.timestamps
    end
  end
end
