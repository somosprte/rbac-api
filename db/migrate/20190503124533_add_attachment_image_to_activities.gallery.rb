# frozen_string_literal: true

# This migration comes from gallery (originally 20190503124456)
class AddAttachmentImageToActivities < ActiveRecord::Migration[5.2]
  def self.up
    change_table :gallery_activities do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :gallery_activities, :image
  end
end
