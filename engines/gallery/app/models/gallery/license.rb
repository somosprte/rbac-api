# frozen_string_literal: true

module Gallery
  class License < ApplicationRecord
    enum allow_commercial_use: { 'non-commercial': 0, 'commercial': 1 }
    enum allow_modify: { 'non-modify': 0, 'modify': 1, 'modify+share-alike': 2 }

    has_many :activities, class_name: 'Gallery::Activity'
  end
end
