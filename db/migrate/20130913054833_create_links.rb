class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name, :url, :limit => 200, :null => false
      t.integer :visits_count, :default => 0, :null => false
      t.boolean :featured, :null => false
      t.timestamps
    end
  end
end
