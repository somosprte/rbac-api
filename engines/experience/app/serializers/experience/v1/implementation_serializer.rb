module Experience
    module V1
        class ImplementationSerializer < ActiveModel::Serializer
            attributes :id,
                       :person,
                       :description,
                       :date_implementation,
                       :place_implementation,
                       :number_participants


        
            
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