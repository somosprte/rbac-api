module Gallery
    module V1
        class SpecificMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :quantity 
        end
    end
end