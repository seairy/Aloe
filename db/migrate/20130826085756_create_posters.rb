# -*- encoding : utf-8 -*-
class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :title, :limit => 200, :null => false
      t.string :image, :limit => 500
      t.string :url, :limit => 200, :null => false
      t.integer :position, :default => 1, :null => false
      t.boolean :available, :null => false
      t.timestamps
    end
  end
end
