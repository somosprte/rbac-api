# frozen_string_literal: true

module Experience
  class Favorite < ApplicationRecord
    belongs_to :favoriteable, polymorphic: true, optional: true
    belongs_to :person, class_name: 'User::Person'
  end
end
