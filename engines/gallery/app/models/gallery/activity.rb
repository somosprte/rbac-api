module Gallery
  class Activity < ApplicationRecord
    has_many :activity_scopes,    class_name: 'Gallery::ActivityScope'
    has_many :scopes, through: :activity_scopes, class_name: 'Gallery::Scope'
  end
end
