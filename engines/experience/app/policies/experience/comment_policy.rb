# frozen_string_literal: true

module Experience
  class CommentPolicy < ApplicationPolicy
    def update?
      user.admin? || record.person == user.usereable
    end

    def destroy?
      user.admin? || record.person == user.usereable
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
  end
