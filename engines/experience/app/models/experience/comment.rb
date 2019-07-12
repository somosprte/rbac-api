# frozen_string_literal: true

module Experience
  class Comment < ApplicationRecord
    belongs_to :commenteable, polymorphic: true, optional: true
    belongs_to :person, class_name: 'User::Person'
  end
end
