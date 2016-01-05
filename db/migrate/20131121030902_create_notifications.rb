# -*- encoding : utf-8 -*-
class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :administrator, :null => false
      t.string :title, :limit => 200, :null => false
      t.text :content
      t.boolean :read, :default => false, :null => false
      t.timestamps
    end
  end
end
