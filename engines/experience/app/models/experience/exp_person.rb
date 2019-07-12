# frozen_string_literal: true

module Experience
  class ExpPerson < ApplicationRecord
    belongs_to :experiencable, polymorphic: true, optional: true
    belongs_to :person, class_name: 'User::Person'
  end
end
