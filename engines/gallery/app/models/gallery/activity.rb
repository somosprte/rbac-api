module Gallery
  class Activity < ApplicationRecord
    enum remixed: [:no, :yes]
    attr_accessor :image, :liked, :favorited, :implemented
    has_many :activity_scopes,    class_name: 'Gallery::ActivityScope',  dependent: :destroy
    has_many :scopes, through: :activity_scopes, class_name: 'Gallery::Scope'
    
    has_many :activity_audiences,    class_name: 'Gallery::ActivityAudience'
    has_many :audiences, through: :activity_audiences, class_name: 'Gallery::Audience',  dependent: :destroy

    has_many :authors,    class_name: 'Gallery::Author',  dependent: :destroy
    has_many :people, through: :authors, class_name: 'User::Person'

    has_many :activity_space_types,    class_name: 'Gallery::ActivitySpaceType',  dependent: :destroy
    has_many :space_types, through: :activity_space_types, class_name: 'Gallery::SpaceType'

    has_many :activity_general_materials,    class_name: 'Gallery::ActivityGeneralMaterial',  dependent: :destroy
    has_many :general_materials, through: :activity_general_materials, class_name: 'Gallery::GeneralMaterial'
  
    #has_many :specific_materials, class_name: 'Gallery::SpecificMaterial', dependent: :destroy
    has_many :likes, class_name: 'Experience::Like', as: :likeable, dependent: :destroy
    has_many :favorites, class_name: 'Experience::Favorite', as: :favoriteable, dependent: :destroy
    
    has_many :inspirations, class_name: 'Gallery::Inspiration', dependent: :destroy
    has_many :activities, through: :inspirations, class_name: "Gallery::Activity"
    
    has_many :implementations, class_name: 'Experience::Implementation', dependent: :destroy
    has_many :comments, class_name: 'Experience::Comment', as: :commenteable, dependent: :destroy

    #accepts_nested_attributes_for :specific_materials, allow_destroy: true
    

    has_attached_file :image, styles: {
      thumb: '100x100#',
      square: '300x300#',
      medium: '600x600#',
      original: '1200x1200#'
    }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    # Copy model, used to remix
    amoeba do
      enable
      include_association :activity_scopes
      include_association :activity_audiences
      include_association :activity_space_types
      include_association :general_materials
      include_association :specific_materials
    end

    def self.search_global(query)
      where("title ilike '%#{query}%' or caption ilike '%#{query}%' or description ilike '%#{query}%' or motivation ilike '%#{query}%'")
    end

    def self.search_by_scope(scope)
      joins(:scopes).where("gallery_scopes.title ilike '%#{scope}%'")
    end

    def self.search_by_author(author)
      joins(:people).where("user_people.name ilike '%#{author}%'")
    end

    def self.search_by_audience(audience)
      joins(:audiences).where("gallery_audiences.name ilike '%#{audience}%'")
    end

    def self.search_by_space_type(space_type)
      joins(:space_types).where("gallery_space_types.title ilike '%#{space_type}%'")
    end

    def self.get_activity_favorites(person)
      joins(:favorites).where("experience_favorites.person_id = '#{person.id}' and experience_favorites.favoriteable_type = 'Gallery::Activity'")
    end

    def liked?(current_user)
      self.liked = likes.where(person: current_user.usereable).present?
    end

    def favorited?(current_user)
      self.favorited = favorites.where(person: current_user.usereable).present?
    end

    def implemented?(current_user)
      self.implemented = implementations.where(person: current_user.usereable).present?
    end

  end
end
