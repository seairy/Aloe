# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :member, :null => false
      t.string :name, :limit => 200, :null => false
      t.string :address, :limit => 500, :null => false
      t.string :postal_code, :limit => 50, :null => false
      t.string :phone, :limit => 200, :null => false
      t.string :mobile, :limit => 200, :null => false
      t.decimal :total_price, :precision => 8, :scale => 2, :null => false
      t.integer :status, :limit => 1, :default => Order::StatusSubmited, :null => false
      t.text :remark
      t.timestamps
    end
  end
end
