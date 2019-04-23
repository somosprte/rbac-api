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
                       :authors

            
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

        end
    end
  end
  