# frozen_string_literal: true

# This migration comes from gallery (originally 20190404194626)
class CreateGalleryActivityScopes < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_activity_scopes, id: :uuid do |t|
      t.uuid :activity_id
      t.uuid :scope_id
      t.timestamps
    end
  end
end
