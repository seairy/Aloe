# -*- encoding : utf-8 -*-
class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.references :role, :null => false
      t.string :account, :limit => 32, :null => false
      t.string :password_digest, :limit => 100, :null => false
      t.string :name, :limit => 100, :null => false
      t.boolean :available, :null => false
      t.datetime :last_signined_at, :current_signined_at
      t.timestamps
    end
  end
end
