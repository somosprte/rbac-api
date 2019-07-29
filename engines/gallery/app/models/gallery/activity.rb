# frozen_string_literal: true

module Gallery
  class Activity < ApplicationRecord
    enum remixed: %i[no yes]
    enum activity_type: %i[internal external]
    attr_accessor :image, :liked, :favorited, :implemented

    belongs_to :license, class_name: 'Gallery::License', optional: true

    has_many :activity_scopes, class_name: 'Gallery::ActivityScope', dependent: :destroy
    has_many :scopes, through: :activity_scopes, class_name: 'Gallery::Scope'

    has_many :activity_audiences, class_name: 'Gallery::ActivityAudience'
    has_many :audiences, through: :activity_audiences, class_name: 'Gallery::Audience', dependent: :destroy

    has_many :authors, class_name: 'Gallery::Author',  dependent: :destroy
    has_many :people, through: :authors, class_name: 'User::Person'

    has_many :activity_space_types, class_name: 'Gallery::ActivitySpaceType', dependent: :destroy
    has_many :space_types, through: :activity_space_types, class_name: 'Gallery::SpaceType'

    has_many :activity_general_materials, class_name: 'Gallery::ActivityGeneralMaterial', dependent: :destroy
    has_many :general_materials, through: :activity_general_materials, class_name: 'Gallery::GeneralMaterial'

    # has_many :specific_materials, class_name: 'Gallery::SpecificMaterial', dependent: :destroy
    has_many :likes, class_name: 'Experience::Like', as: :likeable, dependent: :destroy
    has_many :favorites, class_name: 'Experience::Favorite', as: :favoriteable, dependent: :destroy
    has_many :remixes, class_name: 'Experience::Remix', as: :remixeable, dependent: :destroy

    has_many :inspirations, class_name: 'Gallery::Inspiration', dependent: :destroy
    has_many :activities, through: :inspirations, class_name: 'Gallery::Activity'

    has_many :implementations, class_name: 'Experience::Implementation', dependent: :destroy
    has_many :comments, class_name: 'Experience::Comment', as: :commenteable, dependent: :destroy

    # accepts_nested_attributes_for :specific_materials, allow_destroy: true

    has_attached_file :image, styles: {
      thumb: '100x100#',
      square: '300x300#',
      medium: '600x600#',
      original: '1200x1200#'
    }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    validates :description,
              :motivation,
              :powerful_ideas,
              :products,
              :copyright,
              :space_organization,
              :implementation_steps,
              :duration,
              :scope_ids,
              :audience_ids,
              :space_type_ids,
              :license_id,
              presence: true, if: ->{ activity_type == 'internal' } # for internal only
    validates :external_link, presence: true, if: ->{ activity_type == 'external' } # for external only
    validates :title, :caption, presence: true # for both [internal | external]

    amoeba do
      enable
      include_association :activity_scopes
      include_association :activity_audiences
      include_association :activity_space_types
      include_association :general_materials
    end
  
    scope :search_global, lambda { |query = nil|
      if query
        where("title ilike '%#{query}%' or caption ilike '%#{query}%' or description ilike '%#{query}%' or motivation ilike '%#{query}%'")
      else
        all
      end
    }

    scope :search_by_scopes, lambda { |scopes = nil|
      if scopes
        scopes = scopes.split(',')
        joins(:scopes).where(gallery_scopes: { id: scopes })
      else
        all
      end
    }

    scope :search_by_authors, lambda { |authors = nil|
      if authors
        authors = authors.split(',')
        joins(:people).where(user_people: { id: authors })
      else
        all
      end
    }

    scope :search_by_licenses, lambda { |licenses = nil|
      if licenses
        licenses = licenses.split(',').to_s[1..-2].gsub(/\"/, '\'')
        joins('inner join gallery_licenses ON gallery_licenses.id = gallery_activities.license_id')
        .where("gallery_licenses.id IN (#{licenses})")
      else
        all
      end
    }

    scope :search_by_activity_type, lambda { |activity_type = nil|
      if activity_type
        where("gallery_activities.activity_type = #{activity_type == 'internal' ? 0 : 1}")
      else
        all
      end
    }

    scope :search_by_audiences, lambda { |audiences = nil|
      if audiences
        audiences = audiences.split(',')
        joins(:audiences).where(gallery_audiences: { id: audiences })
      else
        all
      end
    }

    scope :search_by_space_types, lambda { |space_types = nil|
      if space_types
        space_types = space_types.split(',')
        joins(:space_types).where(gallery_space_types: { id: space_types })
      else
        all
      end
    }

    def self.get_users_activities(id, isCurrentUser = true)
      onlyPublished = isCurrentUser ? '' : ' AND gallery_activities.published = true'
      authors = select('gallery_activities.*')
                .joins('inner join gallery_authors ON gallery_activities.id = gallery_authors.activity_id')
                .where("gallery_authors.person_id = '#{id}'#{onlyPublished}")
      creator = select('gallery_activities.*')
                .where("gallery_activities.inserted_by = '#{id}'#{onlyPublished}")
      Kaminari.paginate_array(authors | creator)
    end

    scope :order_by, lambda { |order = nil|
      if order.present?
        select('gallery_activities.*, count(i.activity_id) as total_implementations, count(r.activity_id) as total_remixes, count(f.favoriteable_id) as total_favorites')
        .joins('left join experience_implementations i ON gallery_activities.id = i.activity_id')
        .joins('left join experience_remixes r ON gallery_activities.id = r.remixeable_id')
        .joins('left join experience_favorites f ON gallery_activities.id = f.favoriteable_id')
        .group('gallery_activities.id')
        .order(order)
      else
        all.order(created_at: :desc)
      end
      }

    def self.get_activity_favorites(person)
      joins(:favorites).where("experience_favorites.person_id = '#{person.id}' and experience_favorites.favoriteable_type = 'Gallery::Activity'")
    end

    def self.get_activity_implementations(person)
      joins(:implementations).where("experience_implementations.person_id = '#{person.id}'")
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
