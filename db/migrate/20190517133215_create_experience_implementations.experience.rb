# frozen_string_literal: true

# This migration comes from experience (originally 20190517132212)
class CreateExperienceImplementations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :experience_implementations, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :activity_id
      t.date :date_implementation
      t.string :place_implementation
      t.integer :number_participants
      t.text :description

      t.timestamps
    end
    add_index :experience_implementations, %i[person_id activity_id], unique: true, name: 'experience_implementation_index'
  end
end
