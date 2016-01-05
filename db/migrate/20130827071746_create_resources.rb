# -*- encoding : utf-8 -*-
class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :category, :null => false
      t.string :title, :limit => 200, :null => false
      t.string :author, :organization, :limit => 200
      t.string :image, :limit => 500
      t.text :description
      t.integer :media_type
      t.string :media, :limit => 500
      t.boolean :visible, :featured, :null => false
      t.integer :views_count, :default => 0, :null => false
      t.datetime :displayed_at, :null => false
      t.timestamps
    end
  end
end
