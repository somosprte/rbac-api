User::Engine.routes.draw do
    namespace :v1 do
        resources :people
    end
end