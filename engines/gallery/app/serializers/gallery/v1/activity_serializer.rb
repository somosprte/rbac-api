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
                       :scopes,
                       :audiences,
                       :authors,
                       :space_types,
                       :specific_materials

            
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

        end
    end
  end
  