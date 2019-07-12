# frozen_string_literal: true

require_dependency 'auth/application_controller'

module Auth
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate, only: %i[register login]

      # POST auth/v1/users/register
      def register
        email = register_params[:email]
        if email.blank?
          render_json_error :bad_request, :email_not_informed
        else
          person = Auth.person_class.find_by(email: email)
          if person.nil?
            new_person = Auth.person_class.create(name: register_params[:name],
                                                  email: email,
                                                  birthday: register_params[:birthday])

            new_auth = Auth::User.create(username: email, password: register_params[:password], usereable: new_person)

            render json: new_person, serializer: Auth.person_serializer, status: :created

          else
            render_json_error :bad_request, :exists_email
          end
        end
      end

      # POST auth/v1/users/login
      def login
        username = login_params[:username]
        if username.blank?
          render_json_error :bad_request, :username_not_informed
        else
          password = login_params[:password]
          if password.blank?
            render_json_error :bad_request, :password_not_informed
          else
            auth = Auth::User.find_by(username: username)
            if auth&.authenticate(login_params[:password])
              jwt = Authenticate.issue(user: auth.id)
              person = auth.usereable
              render json: { jwt: jwt, person_id: person.id }
            else
              render_json_error :bad_request, :invalid_password
            end
          end
        end
      end

      private

      def register_params
        params.require(:auth).permit(:email, :password, :name, :birthday)
      end

      def login_params
        params.require(:auth).permit(:username, :password)
      end
    end
  end
end
