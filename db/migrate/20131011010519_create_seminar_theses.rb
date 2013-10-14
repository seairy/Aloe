class CreateSeminarTheses < ActiveRecord::Migration
  def change
    create_table :seminar_theses do |t|
      t.references :category, :null => false
      t.string :title, :limit => 500, :null => false
      t.string :author, :limit => 200
      t.string :document, :limit => 500
      t.integer :position, :default => 1, :null => false
      t.timestamps
    end
  end
end
