# -*- encoding : utf-8 -*-
class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :role, :null => false
      t.string :controller_name, :limit => 100, :null => false
      t.string :action_name, :limit => 100, :null => false
      t.boolean :allowed, :null => false
      t.timestamps
    end
  end
end
