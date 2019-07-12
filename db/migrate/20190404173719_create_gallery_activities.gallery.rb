# frozen_string_literal: true

# This migration comes from gallery (originally 20190404173139)
class CreateGalleryActivities < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :gallery_activities, id: :uuid do |t|
      t.string :title
      t.string :caption
      t.text   :description
      t.text   :motivation
      t.text   :powerful_ideas
      t.text   :products
      t.text   :requirements
      t.boolean :published
      t.string  :version_history
      t.string  :copyright
      t.string  :license_type
      t.timestamps
    end
  end
end
