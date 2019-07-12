# frozen_string_literal: true

class CreateGalleryActivitySpaceTypes < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_activity_space_types, id: :uuid do |t|
      t.uuid :activity_id
      t.uuid :space_type_id

      t.timestamps
    end
  end
end
