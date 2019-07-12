# frozen_string_literal: true

module Auth
  class User < ApplicationRecord
    enum role: %i[normal admin]
    has_secure_password

    belongs_to :usereable, polymorphic: true, optional: true
  end
end
