# frozen_string_literal: true

# This migration comes from gallery (originally 20190715130557)

class AddColumnToGalleryActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :inserted_by, :uuid
    add_column :gallery_activities, :external_authors, :string, array: true, default: []
    add_column :gallery_activities, :external_link, :string
    add_column :gallery_activities, :is_abac_author, :boolean, default: false
  end
end
