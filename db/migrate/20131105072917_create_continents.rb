# -*- encoding : utf-8 -*-
class CreateContinents < ActiveRecord::Migration
  def change
    create_table :continents do |t|
      t.string :name, :limit => 200, :null => false
      t.timestamps
    end
  end
end
