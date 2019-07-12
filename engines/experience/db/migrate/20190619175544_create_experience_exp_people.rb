# frozen_string_literal: true

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
