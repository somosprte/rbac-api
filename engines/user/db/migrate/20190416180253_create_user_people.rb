# frozen_string_literal: true

class CreateUserPeople < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :user_people, id: :uuid do |t|
      t.string :name
      t.string :email
      t.date :birthday

      t.timestamps
    end
  end
end
