class CreateMemorabilias < ActiveRecord::Migration
  def change
    create_table :memorabilias do |t|
      t.string :year, :limit => 20, :null => false
      t.text :content
      t.timestamps
    end
  end
end
