# frozen_string_literal: true

class CreateGalleryGeneralMaterials < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_general_materials, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
