# frozen_string_literal: true

class CreateGallerySpecificMaterials < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_specific_materials, id: :uuid do |t|
      t.string :name
      t.integer :quantity
      t.uuid :activity_id
      t.timestamps
    end
  end
end
