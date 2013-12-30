# -*- encoding : utf-8 -*-
class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :member, :null => false
      t.string :name, :limit => 200
      t.integer :gender, :limit => 1
      t.string :title, :limit => 200
      t.string :phone, :limit => 200
      t.string :mobile, :limit => 200
      t.string :fax, :limit => 200
      t.timestamps
    end
  end
end
