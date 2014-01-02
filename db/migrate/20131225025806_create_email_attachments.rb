# -*- encoding : utf-8 -*-
class CreateEmailAttachments < ActiveRecord::Migration
  def change
    create_table :email_attachments do |t|
      t.references :email, :null => false
      t.string :file, :limit => 500
      t.timestamps
    end
  end
end
