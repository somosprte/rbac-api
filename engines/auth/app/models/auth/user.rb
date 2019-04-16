module Auth
  class User < ApplicationRecord
    enum role: [:normal, :admin]
    has_secure_password

    belongs_to :usereable, polymorphic: true, optional:true
  end
end
