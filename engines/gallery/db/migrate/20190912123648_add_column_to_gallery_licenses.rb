# frozen_string_literal: true

class AddColumnToGalleryLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_licenses, :allow_commercial_use, :integer
    add_column :gallery_licenses, :allow_modify, :integer 
  end
end
