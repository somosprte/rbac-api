# frozen_string_literal: true

module Gallery
  module V1
    class ActivitySerializer < ActiveModel::Serializer
      attributes :id,
                 :title,
                 :caption,
                 :description,
                 :motivation,
                 :powerful_ideas,
                 :products,
                 :requirements,
                 :published,
                 :version_history,
                 :copyright,
                 :space_organization,
                 :implementation_steps,
                 :implementation_tips,
                 :reflection_assessment,
                 :duration,
                 :references,
                 :remixed,
                 :activity_type,
                 :liked,
                 :favorited,
                 :implemented,
                 :license,
                 :scopes,
                 :audiences,
                 :inspirations,
                 :is_abac_author,
                 :authors,
                 :inserted_by,
                 :external_authors,
                 :external_link,
                 :space_types,
                 :specific_materials,
                 :general_materials,
                 :images,
                 :comments,
                 :remixes,
                 :likes,
                 :implementations,
                 :total_implementations,
                 :total_likes,
                 :total_favorites,
                 :total_remixes,
                 :total_comments,
                 :created_at,
                 :updated_at

      def license
        Gallery::V1::LicenseSerializer.new(object.license, root: false) if object.license
      end

      def scopes
        object.scopes.map do |scope|
          Gallery::V1::ScopeSerializer.new(scope, root: false)
        end
      end

      def audiences
        object.audiences.map do |audience|
          Gallery::V1::AudienceSerializer.new(audience, root: false)
        end
      end

      def authors
        object.people.map do |author|
          User::V1::PersonSerializer.new(author, root: false)
        end
      end

      def inserted_by
        User::V1::PersonSerializer.new(
          User::Person.find_by(id: object.inserted_by),
          root: false
        ) if User::Person.find_by(id: object.inserted_by)
      end

      def space_types
        object.space_types.map do |space_type|
          Gallery::V1::SpaceTypeSerializer.new(space_type, root: false)
        end
      end

      # def specific_materials
      #     object.specific_materials.map{|specific_material|
      #         Gallery::V1::SpecificMaterialSerializer.new(specific_material, root: false)
      #     }
      # end

      def general_materials
        object.general_materials.map do |general_material|
          Gallery::V1::GeneralMaterialSerializer.new(general_material, root: false, scope: object)
        end
      end

      def inspirations
        object.inspirations.map do |inspiration|
          Gallery::V1::InspirationSerializer.new(inspiration, root: false)
        end
      end

      def comments
        object.comments.order('created_at DESC').map do |comment|
          Experience::V1::CommentSerializer.new(comment, root: false)
        end
      end

      def remixes
        object.remixes.order('created_at DESC').map do |remix|
          Experience::V1::RemixSerializer.new(remix, root: false)
        end
      end

      def likes
        object.likes.map do |like|
          Experience::V1::LikeSerializer.new(like, root: false)
        end
      end

      def implementations
        object.implementations.order('created_at DESC').map do |implementation|
          Experience::V1::ImplementationSerializer.new(implementation, root: false)
        end
      end

      def images
        {
          original: object.image.url,
          medium: object.image.url(:medium),
          square: object.image.url(:square),
          thumbnail: object.image.url(:thumb)
        }
      end

      def total_implementations
        object.implementations.size
      end

      def total_likes
        object.likes.size
      end

      def total_favorites
        object.favorites.size
      end

      def total_remixes
        object.remixes.size
      end

      def total_comments
        object.comments.size
      end
    end
  end
end
