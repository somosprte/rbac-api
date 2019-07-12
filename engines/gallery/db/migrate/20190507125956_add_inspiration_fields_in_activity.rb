# frozen_string_literal: true

class AddInspirationFieldsInActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_activities, :inspiration, :text
    add_column :gallery_activities, :references, :text
  end
end
