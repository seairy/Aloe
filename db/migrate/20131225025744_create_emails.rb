# -*- encoding : utf-8 -*-
class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :recipient, :subject, :limit => 200, :null => false
      t.text :content
      t.boolean :sent, :default => false, :null => false
      t.datetime :sent_at
      t.timestamps
    end
  end
end
