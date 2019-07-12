# frozen_string_literal: true

# This migration comes from gallery (originally 20190712114353)
class AddActivityTypeToGalleryActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :activity_type, :integer
  end
end
