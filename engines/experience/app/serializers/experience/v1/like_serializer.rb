# frozen_string_literal: true

module Experience
  module V1
    class LikeSerializer < ActiveModel::Serializer
      attributes :id,
                 :person

      def person
        unless object&.person.nil?
          User::V1::PersonSerializer.new(object.person, root: false)
        end
      end
    end
  end
end
