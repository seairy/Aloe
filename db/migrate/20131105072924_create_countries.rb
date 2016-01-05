# -*- encoding : utf-8 -*-
class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.references :continent, :null => false
      t.string :name, :limit => 200, :null => false
      t.timestamps
    end
  end
end
