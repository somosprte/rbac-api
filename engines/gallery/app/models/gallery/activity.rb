module Gallery
  class Activity < ApplicationRecord
    has_many :activity_scopes,    class_name: 'Gallery::ActivityScope'
    has_many :scopes, through: :activity_scopes, class_name: 'Gallery::Scope'
    
    has_many :activity_audiences,    class_name: 'Gallery::ActivityAudience'
    has_many :audiences, through: :activity_audiences, class_name: 'Gallery::Audience'

    has_many :authors,    class_name: 'Gallery::Author'
    has_many :people, through: :authors, class_name: 'User::Person'
  
  end
end
