# frozen_string_literal: true

module Gallery
  module V1
    class InspirationSerializer < ActiveModel::Serializer
      attributes :id,
                 :activity_two_id,
                 :title
    end
  end
end
