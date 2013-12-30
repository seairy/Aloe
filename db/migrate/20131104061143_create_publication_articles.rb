# -*- encoding : utf-8 -*-
class CreatePublicationArticles < ActiveRecord::Migration
  def change
    create_table :publication_articles do |t|
      t.references :category, :null => false
      t.string :title, :limit => 200, :null => false
      t.string :author, :limit => 200, :null => false
      t.string :organization, :limit => 500, :null => false
      t.text :abstract
      t.timestamps
    end
  end
end
