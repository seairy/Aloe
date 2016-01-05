# -*- encoding : utf-8 -*-
class CreateSeminarVideos < ActiveRecord::Migration
  def change
    create_table :seminar_videos do |t|
      t.references :seminar, :null => false
      t.string :title, :limit => 200, :null => false
      t.text :description
      t.string :image, :media, :limit => 500
      t.boolean :visible, :null => false
      t.timestamps
    end
  end
end
