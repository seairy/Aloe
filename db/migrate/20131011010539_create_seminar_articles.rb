class CreateSeminarArticles < ActiveRecord::Migration
  def change
    create_table :seminar_articles do |t|
      t.references :seminar, :null => false
      t.string :title, :source, :limit => 200
      t.text :content
      t.boolean :visible, :featured, :null => false
      t.integer :views_count, :default => 0, :null => false
      t.datetime :displayed_at, :null => false
      t.timestamps
    end
  end
end
