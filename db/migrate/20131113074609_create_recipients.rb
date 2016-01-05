# -*- encoding : utf-8 -*-
class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :member, :null => false
      t.string :name, :limit => 200, :null => false
      t.boolean :available, :default => true, :null => false
      t.boolean :subscribed, :default => true, :null => false
      t.timestamps
    end
  end
end
