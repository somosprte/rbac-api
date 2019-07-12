# frozen_string_literal: true

class CreateGalleryAuthors < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_authors, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :activity_id

      t.timestamps
    end
  end
end
