# frozen_string_literal: true

module Experience
  class Implementation < ApplicationRecord
    belongs_to :person, class_name: 'User::Person'
    belongs_to :activity, class_name: 'Gallery::Activity'

    has_many :exp_people, class_name: 'Experience::ExpPerson', source: :experiencable, foreign_key: 'experiencable_id', dependent: :destroy
    has_many :people, through: :exp_people, class_name: 'User::Person'
  end
end
