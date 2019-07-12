# frozen_string_literal: true

class AddDescriptionSpecificMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_specific_materials, :description, :text
  end
end
