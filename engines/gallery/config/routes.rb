Gallery::Engine.routes.draw do
    namespace :v1 do
        resources :activities
        resources :scopes
        resources :audiences
        resources :space_types
        resources :general_materials
        match 'activities/:id/like', to: 'activities#like', via: [:get]
    end
end
