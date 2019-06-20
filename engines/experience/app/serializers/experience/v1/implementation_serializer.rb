module Experience
    module V1
        class ImplementationSerializer < ActiveModel::Serializer
            attributes :id,
                       :person,
                       :description,
                       :date_implementation,
                       :place_implementation,
                       :number_participants,
                       :authors


        
            
            def person
                unless object&.person.nil?
                    User::V1::PersonSerializer.new(object.person, root: false)
                else
                    nil
                end
            end

            def authors
                object.people.map{|author|
                    User::V1::PersonSerializer.new(author, root: false)
                }   
            end
        end
    end
end