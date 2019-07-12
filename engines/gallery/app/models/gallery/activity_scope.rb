# frozen_string_literal: true

module Gallery
  class ActivityScope < ApplicationRecord
    belongs_to :activity, class_name: 'Gallery::Activity'
    belongs_to :scope, class_name: 'Gallery::Scope'
  end
end
