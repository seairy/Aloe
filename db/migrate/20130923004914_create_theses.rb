class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :title, :author, :limit => 200, :null => false
      t.string :image, :limit => 500
      t.text :abstract
      t.string :keywords, :limit => 500
      t.string :published_in, :limit => 200
      t.string :volume, :limit => 50
      t.date :published_at
      t.string :link, :limit => 500
      t.boolean :featured, :null => false
      t.timestamps
    end
  end
end
