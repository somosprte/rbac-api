# frozen_string_literal: true

module Gallery
  class License < ApplicationRecord
    has_many :activities, class_name: 'Gallery::Activity'
  end
end
