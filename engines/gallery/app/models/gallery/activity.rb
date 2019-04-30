module Gallery
  class Activity < ApplicationRecord
    has_many :activity_scopes,    class_name: 'Gallery::ActivityScope'
    has_many :scopes, through: :activity_scopes, class_name: 'Gallery::Scope'
    
    has_many :activity_audiences,    class_name: 'Gallery::ActivityAudience'
    has_many :audiences, through: :activity_audiences, class_name: 'Gallery::Audience'

    has_many :authors,    class_name: 'Gallery::Author'
    has_many :people, through: :authors, class_name: 'User::Person'

    has_many :activity_space_types,    class_name: 'Gallery::ActivitySpaceType'
    has_many :space_types, through: :activity_space_types, class_name: 'Gallery::SpaceType'

    has_many :activity_general_materials,    class_name: 'Gallery::ActivityGeneralMaterial'
    has_many :general_materials, through: :activity_general_materials, class_name: 'Gallery::GeneralMaterial'
  
    has_many :specific_materials, class_name: 'Gallery::SpecificMaterial'

    accepts_nested_attributes_for :specific_materials, allow_destroy: true

    def self.search_global(query)
      where("title ilike '%#{query}%' or caption ilike '%#{query}%' or description ilike '%#{query}%' or motivation ilike '%#{query}%'")
    end

  end
end
