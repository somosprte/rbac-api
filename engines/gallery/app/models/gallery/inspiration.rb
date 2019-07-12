# frozen_string_literal: true

module Gallery
  class Inspiration < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :activity_two, class_name: 'Gallery::Activity'
  end
end
