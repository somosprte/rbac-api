# frozen_string_literal: true

module Gallery
  class Audience < ApplicationRecord
    has_many :activity_audiences,    class_name: 'Gallery::ActivityAudience'
    has_many :activities, through: :activity_audiences, class_name: 'Gallery::Activity'
  end
end
