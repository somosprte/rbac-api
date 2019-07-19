# frozen_string_literal: true

User::Engine.routes.draw do
  namespace :v1 do
    resources :people
    match 'people/favorites/activities', to: 'people#get_favorites_activities', via: [:get]
    match 'people/implementations/activities', to: 'people#get_implementations_activities', via: [:get]
    match 'people/current_user/activities', to: 'people#get_people_activities', via: [:get]
    match 'people/:id/activities', to: 'people#get_others_users_activities', via: [:get]
  end
end
