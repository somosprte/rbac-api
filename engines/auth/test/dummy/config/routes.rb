# frozen_string_literal: true

Rails.application.routes.draw do
  mount Auth::Engine => '/auth'
end
