# frozen_string_literal: true

module Gallery
  class Scope < ApplicationRecord
    has_many :activity_scopes, class_name: 'Gallery::ActivityScope'
    has_many :activities, through: :activity_scopes, class_name: 'Gallery::Activity'
  end
end
