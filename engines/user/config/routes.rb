User::Engine.routes.draw do
    namespace :v1 do
        resources :people
        match 'people/favorites/activities', to: 'people#get_favorites_activities', via: [:get]
    end
end
