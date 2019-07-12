# frozen_string_literal: true

# This migration comes from gallery (originally 20190514190343)
class AddDescriptionSpecificMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_specific_materials, :description, :text
  end
end
