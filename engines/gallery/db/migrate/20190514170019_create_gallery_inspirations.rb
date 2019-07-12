# frozen_string_literal: true

class CreateGalleryInspirations < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_inspirations, id: :uuid do |t|
      t.uuid :activity_id
      t.uuid :activity_two_id
      t.string :title
      t.text :activity_link
      t.timestamps
    end
  end
end
