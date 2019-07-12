# frozen_string_literal: true

class CreateExperienceRemixes < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :experience_remixes, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :remixeable_id
      t.string :remixeable_type

      t.timestamps
    end
  end
end
