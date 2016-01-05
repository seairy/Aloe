# -*- encoding : utf-8 -*-
class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.string :name, :limit => 200
      t.text :brief_introduction, :introduction
      t.references :newsletter
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
