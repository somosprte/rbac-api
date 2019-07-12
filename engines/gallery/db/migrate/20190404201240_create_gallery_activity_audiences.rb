# frozen_string_literal: true

class CreateGalleryActivityAudiences < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_activity_audiences, id: :uuid do |t|
      t.uuid :activity_id
      t.uuid :audience_id

      t.timestamps
    end
  end
end
