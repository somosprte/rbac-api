# frozen_string_literal: true

module Gallery
  class ActivityAudience < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :audience, class_name: 'Gallery::Audience'
  end
end
