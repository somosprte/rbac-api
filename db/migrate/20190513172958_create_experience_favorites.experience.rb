# frozen_string_literal: true

# This migration comes from experience (originally 20190513170232)
class CreateExperienceFavorites < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :experience_favorites, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :favoriteable_id
      t.string :favoriteable_type
      t.timestamps
    end
    add_index :experience_favorites, %i[person_id favoriteable_id favoriteable_type], unique: true, name: 'experience_favorite_index'
  end
end
