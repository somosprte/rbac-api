# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Gallery::Engine, at: '/gallery'
  mount Auth::Engine, at: '/auth'
  mount User::Engine, at: '/user'
  mount Experience::Engine, at: '/experience'
end
