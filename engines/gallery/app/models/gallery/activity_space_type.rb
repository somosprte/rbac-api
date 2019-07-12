# frozen_string_literal: true

module Gallery
  class ActivitySpaceType < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :space_type, class_name: 'Gallery::SpaceType'
  end
end
