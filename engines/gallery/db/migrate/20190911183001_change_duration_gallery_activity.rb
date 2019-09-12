# frozen_string_literal: true

class ChangeDurationGalleryActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :gallery_activities, :duration, :text
    add_column :gallery_activities, :class_duration, :integer, default: 50
    add_column :gallery_activities, :class_quantity, :integer, default: 1 
  end
end
