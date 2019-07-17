# frozen_string_literal: true

module Experience
  module V1
    class RemixSerializer < ActiveModel::Serializer
      attributes :id, :activity

      def activity
        unless object&.activity_id.nil?
          obj = Gallery::Activity.find_by(id: object.activity_id)
          Gallery::V1::ActivitySerializer.new(obj, root: false)
        end
      end
    end
  end
end
