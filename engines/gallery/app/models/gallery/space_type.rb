# frozen_string_literal: true

module Gallery
  class SpaceType < ApplicationRecord
    has_many :activity_space_types, class_name: 'Gallery::ActivitySpaceType'
    has_many :activities, through: :activity_space_types, class_name: 'Gallery::Activity'
  end
end
