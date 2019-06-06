module Gallery
    module V1
        class GeneralMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :description,
                       :quantity
                       
            
            def quantity
            end

                       
        end
    end
end