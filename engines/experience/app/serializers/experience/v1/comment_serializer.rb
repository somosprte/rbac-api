module Experience
    module V1
        class CommentSerializer < ActiveModel::Serializer
            attributes :id,
                       :person,
                       :text


        
            
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