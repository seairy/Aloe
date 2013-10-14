class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name, :limit => 200, :null => false
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
