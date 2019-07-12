# frozen_string_literal: true

Experience::Engine.routes.draw do
  namespace :v1 do
    resources :comments
    resources :implementations
  end
end
