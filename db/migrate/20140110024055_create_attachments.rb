class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name, :limit => 200
      t.string :file, :limit => 500
      t.timestamps
    end
  end
end
