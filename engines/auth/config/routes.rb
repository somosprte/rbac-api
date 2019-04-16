Auth::Engine.routes.draw do
    namespace :v1 do
        match 'users/register', to: 'users#register', via: [:post]
    end
end
