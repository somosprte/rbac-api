require_dependency "auth/application_controller"

module Auth
    module V1
        class UsersController < ApplicationController
            skip_before_action :authenticate, only: %i[register]
            def register
                username = register_params[:username]
                unless username.blank?
                    auth_username = Auth::User.find_by(username:username)
                    if auth_username.nil?
                        email = register_params[:email]
                        unless email.blank?
                            person = Auth.person_class.find_by(email:email)
                            if person.nil?
                                new_person = Auth.person_class.create(name:register_params[:name], 
                                            email:email,
                                            birthday:register_params[:birthday])
                                
                                new_auth = Auth::User.create(username:username, password:register_params[:password], usereable:new_person)
                                
                                render json: new_person, serializer: Auth.person_serializer, status: :created

                            else
                                render_json_error :bad_request, :exists_email
                            end
                        else
                            render_json_error :bad_request, :email_not_informed
                        end
                    else
                        render_json_error :bad_request, :exists_username
                    end
                else
                    render_json_error :bad_request, :username_not_informed
                end
            end

            private
                def register_params
                    params.require(:auth).permit(:username, :email, :password, :name, :birthday)
                end
        end
    end
end