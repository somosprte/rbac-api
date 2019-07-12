# frozen_string_literal: true

module Gallery
  module V1
    class SpecificMaterialSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description,
                 :quantity
    end
  end
end
