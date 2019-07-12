# frozen_string_literal: true

module Gallery
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # protect_from_forgery with: :exception
    private

    def user_not_authorized
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
