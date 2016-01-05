# -*- encoding : utf-8 -*-
class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name, :limit => 200, :null => false
      t.text :description
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
