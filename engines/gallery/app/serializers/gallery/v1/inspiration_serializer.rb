module Gallery
    module V1
        class InspirationSerializer < ActiveModel::Serializer
            attributes :id,
                       :title,
                       :activity_id,
                       :activity_two_id, 
                       :activity_link 
        end
    end
end