# frozen_string_literal: true

module Gallery
  module V1
    class LicenseSerializer < ActiveModel::Serializer
      attributes :id, :title, :acronym, :version, :description, :external_link
    end
  end
end
