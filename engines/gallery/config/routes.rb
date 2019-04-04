Gallery::Engine.routes.draw do
    namespace :v1 do
        resources :activities
    end
end
