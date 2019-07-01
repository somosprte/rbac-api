# frozen_string_literal: true

module Experience
  module V1
    class RemixSerializer < ActiveModel::Serializer
      attributes :id, :activity

      def activity
        Gallery::Activity.find_by(id: object.activity_id) unless object.activity_id.nil?
      end

    end
  end
end
