# -*- encoding : utf-8 -*-
class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :type, :limit => 20, :null => false
      t.string :account, :limit => 100, :null => false
      t.string :hashed_password, :limit => 32
      t.string :chinese_name, :limit => 200
      t.string :foreign_name, :limit => 200
      t.references :country
      t.string :province, :limit => 200
      t.string :address, :limit => 500
      t.string :postal_code, :limit => 50
      t.text :description
      ####################################
      # individual member properties
      t.integer :degree, :limit => 1
      t.string :organization_name, :limit => 200
      t.string :dispatched_organization_name, :limit => 200
      t.boolean :president_of_ci, :default => false, :null => false
      ####################################
      # organization member properties
      t.integer :organization_type, :limit => 1
      t.boolean :profit
      t.string :website, :limit => 200
      ####################################
      t.boolean :public, :null => false
      t.text :remark
      t.decimal :balance, :precision => 8, :scale => 2, :default => 0, :null => false
      t.boolean :approved, :default => false, :null => false
      t.boolean :permanent, :default => false, :null => false
      t.date :joined_at
      t.date :expired_at, :default => '2008-01-01'
      t.date :current_signined_at, :last_signined_at
      t.timestamps
    end
  end
end
