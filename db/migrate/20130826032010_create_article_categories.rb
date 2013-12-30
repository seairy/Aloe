# -*- encoding : utf-8 -*-
class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :name, :limit => 200, :null => false
      t.integer :position, :limit => 1, :null => false
      t.boolean :default, :default => false, :null => false
      t.timestamps
    end
  end
end
