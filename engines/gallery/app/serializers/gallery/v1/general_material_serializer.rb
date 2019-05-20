module Gallery
    module V1
        class GeneralMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :quantity,
                       :description 
        end
    end
end