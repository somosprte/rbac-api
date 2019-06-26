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
                       :license_type,
                       :space_organization,
                       :implementation_steps,
                       :implementation_tips,
                       :reflection_assessment,
                       :duration,
                       :references,
                       :remixed,
                       :liked,
                       :favorited,
                       :implemented,
                       :scopes,
                       :audiences,
                       :inspirations,
                       :authors,
                       :space_types,
                       :specific_materials,
                       :general_materials,
                       :images,
                       :comments,
                       :likes,
                       :implementations,
                       :total_implementations,
                       :total_likes,
                       :total_favorites,
                       :total_remixes,
                       :total_comments
            
            def scopes
                object.scopes.map{|scope|
                    Gallery::V1::ScopeSerializer.new(scope, root: false)
                }   
            end

            def audiences
                object.audiences.map{|audience|
                    Gallery::V1::AudienceSerializer.new(audience, root: false)
                }   
            end

            def authors
                object.people.map{|author|
                    User::V1::PersonSerializer.new(author, root: false)
                }   
            end

            def space_types
                object.space_types.map{|space_type|
                    Gallery::V1::SpaceTypeSerializer.new(space_type, root: false)
                }   
            end

            # def specific_materials
            #     object.specific_materials.map{|specific_material|
            #         Gallery::V1::SpecificMaterialSerializer.new(specific_material, root: false)
            #     }   
            # end

            def general_materials
                object.general_materials.map{|general_material|
                    Gallery::V1::GeneralMaterialSerializer.new(general_material, root: false)
                }   
            end

            def inspirations
                object.inspirations.map{|inspiration|
                    Gallery::V1::InspirationSerializer.new(inspiration, root: false)
                }   
            end

            def comments
                object.comments.order("created_at DESC").map{|comment|
                    Experience::V1::CommentSerializer.new(comment, root: false)
                }   
            end

            def likes
                object.likes.map{|like|
                    Experience::V1::LikeSerializer.new(like, root: false)
                }   
            end

            def implementations
                object.implementations.order("created_at DESC").map{|implementation|
                    Experience::V1::ImplementationSerializer.new(implementation, root: false)
                }   
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
  