# frozen_string_literal: true

# This migration comes from gallery (originally 20190424204458)
class CreateGalleryActivityGeneralMaterials < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_activity_general_materials, id: :uuid do |t|
      t.uuid :activity_id
      t.uuid :general_material_id
      t.integer :quantity

      t.timestamps
    end
  end
end
