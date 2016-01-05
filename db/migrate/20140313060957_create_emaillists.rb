class CreateEmaillists < ActiveRecord::Migration
  def change
    create_table :emaillists do |t|
      t.string :name, :limit => 100, :null => false
      t.timestamps
    end
  end
end
