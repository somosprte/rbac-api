module Gallery
    module V1
        class GeneralMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :description 
        end
    end
end