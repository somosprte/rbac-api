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
                       :scopes,
                       :audiences

            
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

        end
    end
  end
  