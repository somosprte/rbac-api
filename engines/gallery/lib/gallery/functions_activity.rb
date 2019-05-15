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

        def self.verify_activities_reaction(activities, user, auth)
            
            if auth
                activities.each do |activity|
                    activity.liked = activity.likes.where(person: user.usereable).present?
                    activity.favorited = activity.favorites.where(person: user.usereable).present?
                end
            end
            activities
        end

        def self.reactions_activity(activity, user, auth)
            if auth
                activity.liked?(user)
                activity.favorited?(user)
            end
            activity
        end

        def self.crud_inspirations(activity, activity_params, update=nil)
            ids = []
            activity_params[:activity][:inspirations].each do |inspiration|
                gallery_inspiration = Gallery::Activity.find_by(id:inspiration[:id])
                if gallery_inspiration
                    unless activity.inspirations.find_by(activity_two_id:inspiration[:id])
                        activity.inspirations.create(activity_two_id:inspiration[:id], title:inspiration[:title], activity_link:inspiration[:link])
                    else
                        activity.inspirations.update(title:inspiration[:title], activity_link:inspiration[:link])
                    end
                end
                ids.push(inspiration[:id])
            end
            if update == true
                sync_inspirations = Gallery::Inspiration.where(activity_id:activity.id).where.not(activity_two_id:ids)
                sync_inspirations.each do |sync|
                    sync.destroy
                end
            end
            return activity
        end

    end
end