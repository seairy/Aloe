# -*- encoding : utf-8 -*-
class CreateSeminarPhotographs < ActiveRecord::Migration
  def change
    create_table :seminar_photographs do |t|
      t.references :seminar, :null => false
      t.string :title, :limit => 200, :null => false
      t.string :image, :limit => 500
      t.boolean :visible, :null => false
      t.timestamps
    end
  end
end
