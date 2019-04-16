require_dependency "auth/application_controller"

module Auth
    module V1
        class UsersController < ApplicationController

            # def register
            #     email = params[:username]
            #     unless params[:email].nil?
            #         email = params[:email]
            #     end
            #     user = User::Person.find_by(email:email)
            #     if user.nil?
            #         puts 'aaaaaaaaaa'
            #     else
            #         render_json_error :bad_request, :exists_email
            #     end
            # end
        end
    end
end