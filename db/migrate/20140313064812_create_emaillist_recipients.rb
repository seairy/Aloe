class CreateEmaillistRecipients < ActiveRecord::Migration
  def change
    create_table :emaillist_recipients do |t|
      t.references :emaillist, :null => false
      t.string :name, :limit => 200, :null => false
      t.boolean :available, :default => true, :null => false
      t.timestamps
    end
  end
end
