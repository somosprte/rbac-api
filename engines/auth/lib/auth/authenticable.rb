# frozen_string_literal: true

module Auth
  module Authenticable
    def logged_in?
      puts params
      !!current_user
    end

    def current_user
      if auth_present?
        user = Auth::User.find(auth_token['user'])
        @current_user ||= user if user
      end
    end

    def authenticate
      render json: { error: 'unauthorized' }, status: 401 unless logged_in?
    end

    private

    def token
      request.env['HTTP_AUTHORIZATION'].scan(/Bearer(.*)$/).flatten.last.strip
    end

    def auth_token
      Auth::Authenticate.decode(token)
    end

    def auth_present?
      x = request.env.fetch('HTTP_AUTHORIZATION', '').scan(/Bearer/).flatten.first
      !!x
    end
  end
end
