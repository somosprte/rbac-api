# frozen_string_literal: true

# This migration comes from gallery (originally 20190423175601)
class AddColumnsRegisteredActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :space_organization, :text
    add_column :gallery_activities, :implementation_steps, :text
    add_column :gallery_activities, :implementation_tips, :text
    add_column :gallery_activities, :reflection_assessment, :text
    add_column :gallery_activities, :duration, :text
  end
end
