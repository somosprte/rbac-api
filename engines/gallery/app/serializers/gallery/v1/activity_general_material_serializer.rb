module Gallery
    module V1
        class ActivityGeneralMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :quantity
        end
    end
end