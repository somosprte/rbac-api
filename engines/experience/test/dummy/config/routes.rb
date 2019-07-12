# frozen_string_literal: true

Rails.application.routes.draw do
  mount Experience::Engine => '/experience'
end
