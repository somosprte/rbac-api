module Auth
  class User < ApplicationRecord
    enum role: [:normal, :admin]
    has_secure_password
  end
end
