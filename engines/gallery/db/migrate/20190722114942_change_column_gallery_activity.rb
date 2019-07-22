# frozen_string_literal: true

class ChangeColumnGalleryActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :gallery_activities, :license, type: :uuid, foreign_key: {to_table: :gallery_licenses}
  end
end
