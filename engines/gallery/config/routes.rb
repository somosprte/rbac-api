Gallery::Engine.routes.draw do
    namespace :v1 do
        resources :activities
        resources :scopes
        resources :audiences
        resources :space_types
    end
end
