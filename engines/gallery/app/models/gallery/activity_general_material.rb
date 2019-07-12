# frozen_string_literal: true

module Gallery
  class ActivityGeneralMaterial < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :general_material, class_name: 'Gallery::GeneralMaterial'
  end
end
