Gallery::Engine.routes.draw do
    namespace :v1 do
        resources :activities
        resources :scopes
        resources :audiences
        resources :space_types
        resources :general_materials
        match 'activities/:id/like', to: 'activities#like', via: [:get]
        match 'activities/:id/favorite', to: 'activities#favorite', via: [:get]
        match 'activities/:id/remix', to: 'activities#remix', via: [:post]
        match 'activities/:id/implement', to: 'activities#implement', via: [:post]
    end
end
