# frozen_string_literal: true

module Experience
  module V1
    class RemixSerializer < ActiveModel::Serializer
      attributes :id, :activity

      def activity_id
        object.activity_id
      end

      def activity
        Gallery::Activity.find_by(id: activity_id)
      end

    end
  end
end
