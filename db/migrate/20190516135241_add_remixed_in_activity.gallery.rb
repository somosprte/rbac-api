# frozen_string_literal: true

# This migration comes from gallery (originally 20190516135005)
class AddRemixedInActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :remixed, :integer, default: 0
  end
end
