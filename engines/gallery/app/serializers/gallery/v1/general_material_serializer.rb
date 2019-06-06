module Gallery
    module V1
        class GeneralMaterialSerializer < ActiveModel::Serializer
            attributes :id,
                       :name, 
                       :description,
                       :activity_general_materials
                       
            
            def activity_general_materials
                object.activity_general_materials.map{|activity_general_material|
                    Gallery::V1::ActivityGeneralMaterialSerializer.new(activity_general_material, root: false)
                }   
            end

                       
        end
    end
end