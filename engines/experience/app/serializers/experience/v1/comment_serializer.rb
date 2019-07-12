# frozen_string_literal: true

module Experience
  module V1
    class CommentSerializer < ActiveModel::Serializer
      attributes :id,
                 :person,
                 :text,
                 :created_at

      def person
        unless object&.person.nil?
          User::V1::PersonSerializer.new(object.person, root: false)
        end
      end
    end
  end
end
