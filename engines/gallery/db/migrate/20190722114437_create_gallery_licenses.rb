# frozen_string_literal: true

class CreateGalleryLicenses < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_licenses, id: :uuid  do |t|
      t.string :title
      t.string :acronym
      t.string :version
      t.string :description
      t.string :external_link

      t.timestamps
    end
  end
end
