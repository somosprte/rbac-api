# frozen_string_literal: true

module Experience
  class Remix < ApplicationRecord
    belongs_to :remixeable, polymorphic: true, optional: true
    belongs_to :person, class_name: 'User::Person'
  end
end
