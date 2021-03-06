# frozen_string_literal: true

# This migration comes from experience (originally 20190530175520)
class CreateExperienceComments < ActiveRecord::Migration[5.2]
  def change
    create_table :experience_comments, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :commenteable_id
      t.string :commenteable_type
      t.text :text

      t.timestamps
    end
  end
end
