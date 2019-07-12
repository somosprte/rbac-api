# frozen_string_literal: true

module Gallery
  class Author < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :person, class_name: 'User::Person'
  end
end
