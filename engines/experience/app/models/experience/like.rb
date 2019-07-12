# frozen_string_literal: true

module Experience
  class Like < ApplicationRecord
    belongs_to :likeable, polymorphic: true, optional: true
    belongs_to :person, class_name: 'User::Person'
  end
end
