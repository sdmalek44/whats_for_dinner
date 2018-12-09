Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'sessions#create'
      get '/users/:token/searches', to: 'users/searches#index'
      post '/users/:token/searches', to: 'users/searches#create'
    end
  end

end
