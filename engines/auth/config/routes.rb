# frozen_string_literal: true

Auth::Engine.routes.draw do
  namespace :v1 do
    match 'users/register', to: 'users#register', via: [:post]
    match 'users/login', to: 'users#login', via: [:post]
  end
end
