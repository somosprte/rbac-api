# frozen_string_literal: true

Gallery::Engine.routes.draw do
  namespace :v1 do
    resources :activities
    resources :scopes
    resources :audiences
    resources :space_types
    resources :general_materials
    resources :licenses
    match 'activities/:id/like', to: 'activities#like', via: [:get]
    match 'activities/:id/favorite', to: 'activities#favorite', via: [:get]
    match 'activities/:id/remix', to: 'activities#remix', via: [:post]
    match 'activities/:id/implement', to: 'activities#implement', via: [:post]
    match 'activities/:id/likes', to: 'activities#get_likes', via: [:get]
    match 'activities/:id/implementations', to: 'activities#get_implementations', via: [:get]
    match 'activities/:id/comment', to: 'activities#comment', via: [:post]
    match 'activities/:id/pdf', to: 'activities#pdf', via: [:get]
  end
end
