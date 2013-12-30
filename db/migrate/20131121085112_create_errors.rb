# -*- encoding : utf-8 -*-
class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.references :administrator
      t.string :name, :limit => 200, :null => false
      t.text :message, :backtrace
      t.timestamps
    end
  end
end
