module Gallery
  class Activity < ApplicationRecord
    attr_accessor :image, :liked, :favorited
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
    has_many :likes, class_name: 'Experience::Like', as: :likeable, dependent: :destroy
    has_many :favorites, class_name: 'Experience::Favorite', as: :favoriteable, dependent: :destroy
    has_many :inspirations, class_name: 'Gallery::Inspiration', dependent: :destroy
    

    accepts_nested_attributes_for :specific_materials, allow_destroy: true
    

    has_attached_file :image, styles: {
      thumb: '100x100#',
      square: '300x300#',
      medium: '600x600#',
      original: '1200x1200#'
    }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def self.search_global(query)
      where("title ilike '%#{query}%' or caption ilike '%#{query}%' or description ilike '%#{query}%' or motivation ilike '%#{query}%'")
    end

    def liked?(current_user)
      self.liked = likes.where(person: current_user.usereable).present?
    end

    def favorited?(current_user)
      self.favorited = favorites.where(person: current_user.usereable).present?
    end

  end
end
