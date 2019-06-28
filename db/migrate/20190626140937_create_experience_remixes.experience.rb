# This migration comes from experience (originally 20190626140317)
class CreateExperienceRemixes < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :experience_remixes, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :remixeable_id
      t.string :remixeable_type
      t.uuid :activity_id

      t.timestamps
    end
  end
end
