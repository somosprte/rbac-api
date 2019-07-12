# frozen_string_literal: true

module Gallery
  module V1
    class ScopeSerializer < ActiveModel::Serializer
      attributes :id,
                 :title,
                 :description
    end
  end
end
