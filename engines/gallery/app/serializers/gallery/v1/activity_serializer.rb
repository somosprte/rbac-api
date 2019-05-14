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
                       :liked,
                       :favorited,
                       :scopes,
                       :audiences,
                       :inspirations,
                       :authors,
                       :space_types,
                       :specific_materials,
                       :general_materials,
                       :images

            
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

            def specific_materials
                object.specific_materials.map{|specific_material|
                    Gallery::V1::SpecificMaterialSerializer.new(specific_material, root: false)
                }   
            end

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

            def images
                {
                  original: object.image.url,
                  medium: object.image.url(:medium),
                  square: object.image.url(:square),
                  thumbnail: object.image.url(:thumb)
                }
            end

        end
    end
  end
  