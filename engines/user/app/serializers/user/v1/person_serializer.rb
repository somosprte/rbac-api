module User
    module V1
        class PersonSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :email,
                       :birthday 
        end
    end
end