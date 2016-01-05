# -*- encoding : utf-8 -*-
class CreatePublicationCategories < ActiveRecord::Migration
  def change
    create_table :publication_categories do |t|
      t.references :volume, :null => false
      t.string :name, :limit => 200, :null => false
      t.timestamps
    end
  end
end
