# frozen_string_literal: true

module Gallery
  module V1
    class GeneralMaterialSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description,
                 :quantity

      def activity_general_materials
        object.activity_general_materials.map do |activity_general_material|
          Gallery::V1::ActivityGeneralMaterialSerializer.new(activity_general_material, root: false)
        end
      end

      def quantity
        general_material = Gallery::ActivityGeneralMaterial.find_by(activity_id: scope.id, general_material_id: object.id)
        unless general_material.blank?
          general_material.quantity
        else
          nil
        end
      end

    end
  end
end
