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

        def self.verify_activities_reaction(activities, person)
            activities.each do |activity|
                activity.liked = activity.likes.where(person: person).present?
                activity.favorited = activity.favorites.where(person: person).present?
            end
            activities
        end

        def self.reactions_activity(activity, user)
            activity.liked?(user)
            activity.favorited?(user)
            activity
        end

    end
end