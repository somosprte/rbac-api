# frozen_string_literal: true

module User
  class Person < ApplicationRecord
    has_many :authors, class_name: 'Gallery::Author'
    has_many :activities, through: :authors, class_name: 'Gallery::Acitivity'
    has_many :favorites, class_name: 'Experience::Favorite'
  end
end
