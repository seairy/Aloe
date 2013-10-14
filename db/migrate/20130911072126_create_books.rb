class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name, :limit => 500, :null => false
      t.string :image, :limit => 500
      t.string :author, :publisher, :isbn, :limit => 200
      t.date :published_at
      t.integer :currency, :limit => 1, :null => false
      t.decimal :price, :precision => 7, :scale => 2, :null => false
      t.decimal :discount, :precision => 3, :scale => 2, :default => 1, :null => false
      t.text :description
      t.boolean :available, :purchasable, :featured, :null => false
      t.timestamps
    end
  end
end
