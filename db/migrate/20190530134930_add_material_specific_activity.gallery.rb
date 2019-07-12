# frozen_string_literal: true

# This migration comes from gallery (originally 20190530134831)
class AddMaterialSpecificActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :specific_materials, :text
  end
end
