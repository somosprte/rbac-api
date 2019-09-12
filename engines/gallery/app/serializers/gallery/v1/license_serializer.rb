# frozen_string_literal: true

module Gallery
  module V1
    class LicenseSerializer < ActiveModel::Serializer
      attributes :id, :title, :acronym, :version, :description, :external_link, :allow_commercial_use, :allow_modify
    end
  end
end
