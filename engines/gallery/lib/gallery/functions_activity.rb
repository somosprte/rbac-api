module Gallery
    module FunctionsActivity
        def self.crud_general_materials(activity, activity_params, update=nil)
            ids = []
            activity_params[:activity][:general_materials].each do |material|
                material_general = Gallery::GeneralMaterial.find_by(id:material[:id])
                if material_general
                    unless activity.activity_general_materials.find_by(general_material_id:material[:id])
                        activity.activity_general_materials.create(general_material_id:material[:id], quantity:material[:quantity])
                    else
                        activity.activity_general_materials.update(quantity:material[:quantity])
                    end
                end
                ids.push(material[:id])
            end
            if update == true
                    sync_materials = Gallery::ActivityGeneralMaterial.where(activity_id:activity.id).where.not(general_material_id:ids)
                    sync_materials.each do |sync|
                    sync.destroy
                end
            end
            return activity
        end
    end
end