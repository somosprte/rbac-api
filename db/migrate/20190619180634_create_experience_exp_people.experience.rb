# frozen_string_literal: true

# This migration comes from experience (originally 20190619175544)
class CreateExperienceExpPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :experience_exp_people, id: :uuid do |t|
      t.uuid :person_id
      t.uuid :experiencable_id
      t.string :experiencable_type

      t.timestamps
    end
  end
end
