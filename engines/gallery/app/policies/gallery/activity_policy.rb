# frozen_string_literal: true

module Gallery
  class ActivityPolicy < ApplicationPolicy
    def update?
      user.admin? || record.authors.where(person_id: user.usereable.id).exists?
    end

    def destroy?
      user.admin? || record.authors.where(person_id: user.usereable.id).exists?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
