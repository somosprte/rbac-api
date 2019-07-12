# frozen_string_literal: true

module Gallery
  class GeneralMaterial < ApplicationRecord
    has_many :activity_general_materials, class_name: 'Gallery::ActivityGeneralMaterial'
    has_many :activities, through: :activity_general_materials, class_name: 'Gallery::Activity'
  end
end
