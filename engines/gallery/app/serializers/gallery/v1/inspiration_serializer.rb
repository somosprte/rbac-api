module Gallery
    module V1
        class InspirationSerializer < ActiveModel::Serializer
            attributes :id,
                       :activity_two_id
        end
    end
end