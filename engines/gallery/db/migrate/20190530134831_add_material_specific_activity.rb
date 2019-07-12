# frozen_string_literal: true

class AddMaterialSpecificActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :specific_materials, :text
  end
end
