# frozen_string_literal: true

require 'auth/engine'

module Auth
  require 'bcrypt'
  require 'jwt'

  mattr_accessor :person_class
  mattr_accessor :person_serializer

  class Authenticate
    ALGORITHM = 'HS256'

    def self.issue(payload)
      JWT.encode(
        payload,
        auth_secret,
        ALGORITHM
      )
    end

    def self.decode(token)
      JWT.decode(token,
                 auth_secret,
                 true,
                 algorithm: ALGORITHM).first
    end

    def self.auth_secret
      ENV['RBAC_JWT_SECRET']
    end
  end

  def self.person_class
    @@person_class.constantize
  end

  def self.person_serializer
    @@person_serializer.constantize
  end
end
