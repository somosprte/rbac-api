# frozen_string_literal: true

module Gallery
  module V1
    class AudienceSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description
    end
  end
end
