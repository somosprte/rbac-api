# frozen_string_literal: true

class AddRemixedInActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :remixed, :integer, default: 0
  end
end
