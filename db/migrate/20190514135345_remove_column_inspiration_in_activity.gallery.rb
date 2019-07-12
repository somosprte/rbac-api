# frozen_string_literal: true

# This migration comes from gallery (originally 20190514135131)
class RemoveColumnInspirationInActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :gallery_activities, :inspiration
  end
end
