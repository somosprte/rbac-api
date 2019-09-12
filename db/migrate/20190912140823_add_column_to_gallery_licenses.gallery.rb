# frozen_string_literal: true
# This migration comes from gallery (originally 20190912123648)

class AddColumnToGalleryLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_licenses, :allow_commercial_use, :integer
    add_column :gallery_licenses, :allow_modify, :integer 
  end
end
