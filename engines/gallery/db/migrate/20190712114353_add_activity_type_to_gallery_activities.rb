# frozen_string_literal: true

class AddActivityTypeToGalleryActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :activity_type, :integer
  end
end
