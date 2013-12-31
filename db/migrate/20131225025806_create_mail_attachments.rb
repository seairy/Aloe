# -*- encoding : utf-8 -*-
class CreateMailAttachments < ActiveRecord::Migration
  def change
    create_table :mail_attachments do |t|
      t.references :mail, :null => false
      t.string :file, :limit => 500
      t.timestamps
    end
  end
end
