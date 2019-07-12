# frozen_string_literal: true

class AddActivityIdInExperienceRemix < ActiveRecord::Migration[5.2]
  def change
    add_column :experience_remixes, :activity_id, :uuid
  end
end
