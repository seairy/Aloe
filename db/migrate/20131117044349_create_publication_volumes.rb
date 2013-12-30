# -*- encoding : utf-8 -*-
class CreatePublicationVolumes < ActiveRecord::Migration
  def change
    create_table :publication_volumes do |t|
      t.references :publication, :null => false
      t.string :name, :limit => 50, :null => false
      t.string :image, :limit => 500
      t.boolean :featured, :null => false
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
