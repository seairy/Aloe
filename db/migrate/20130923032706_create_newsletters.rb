class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :name, :limit => 200, :null => false
      t.string :image, :limit => 500
      t.text :description
      t.string :asset_url, :limit => 200
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
