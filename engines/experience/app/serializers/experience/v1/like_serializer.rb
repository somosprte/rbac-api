module Experience
    module V1
        class LikeSerializer < ActiveModel::Serializer
            attributes :id,
                       :person


        
            
            def person
                unless object&.person.nil?
                    User::V1::PersonSerializer.new(object.person, root: false)
                else
                    nil
                end
            end
        end
    end
end