# frozen_string_literal: true

class CreateAuthUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :auth_users, id: :uuid do |t|
      t.string :username
      t.integer :role
      t.string :password_digest
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.uuid :usereable_id
      t.string :usereable_type

      t.index :username, unique: true

      t.timestamps
    end
  end
end
