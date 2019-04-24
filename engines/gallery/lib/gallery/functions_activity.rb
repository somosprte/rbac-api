# module Gallery
#     module FunctionsActivity
#         def self.crud_general_materials(activity, activity_params, update=nil)
#             ids = []
#             activity_params[:general_materials].each do |material|
#                 material = Gallery::GeneralMaterial.find_by(material[:id])
#                 if material
#                     unless activity.activity_materials.find_by(material:material)
#                         activity.activity_materials.create(material:material, quantity:material[:quantity])
#                     end
#                 end
#                 ids.push(material[:id])
#             end
#             if update == true
#                     sync_materials = Gallery::ActivityMaterial.where(activity_id:activity.id).where.not(material_id:ids)
#                     sync_materials.each do |sync|
#                     sync.destroy
#                 end
#             end
#             return activity
#         end
#     end
# end