# frozen_string_literal: true

# This migration comes from experience (originally 20190701154539)
class AddActivityIdInExperienceRemix < ActiveRecord::Migration[5.2]
  def change
    add_column :experience_remixes, :activity_id, :uuid
  end
end
