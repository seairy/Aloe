# -*- encoding : utf-8 -*-
class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :member, :null => false
      t.boolean :revenue, :default => true, :null => false
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0, :null => false
      t.datetime :paid_at, :null => false
      t.datetime :before_expired_at, :extended_to, :null => false
      t.string :remark, :limit => 500
      t.timestamps
    end
  end
end
