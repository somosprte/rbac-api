# frozen_string_literal: true
# This migration comes from gallery (originally 20190722114942)

class ChangeColumnGalleryActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :gallery_activities, :license, type: :uuid, foreign_key: {to_table: :gallery_licenses}
  end
end
