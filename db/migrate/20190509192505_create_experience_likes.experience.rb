# frozen_string_literal: true

# This migration comes from experience (originally 20190509183134)
class CreateExperienceLikes < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :experience_likes, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :likeable_id
      t.string :likeable_type

      t.timestamps
    end
    add_index :experience_likes, %i[person_id likeable_id likeable_type], unique: true, name: 'reaction_like_index'
  end
end
