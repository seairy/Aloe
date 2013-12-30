# -*- encoding : utf-8 -*-
class CreateSeminarThesisCategories < ActiveRecord::Migration
  def change
    create_table :seminar_thesis_categories do |t|
      t.references :seminar, :null => false
      t.string :name, :limit => 200
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
