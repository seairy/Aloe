# -*- encoding : utf-8 -*-
class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :limit => 100, :null => false
      t.boolean :omnipotent, :null => false
      t.boolean :creatable, :updatable, :listable, :showable, :destroyable, :searchable, :operatable, :null => false
      t.timestamps
    end
  end
end
