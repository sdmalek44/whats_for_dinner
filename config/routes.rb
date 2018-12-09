Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'sessions#create'
      get '/users/:token/searches', to: 'users/searches#index'
      post '/users/:token/searches', to: 'users/searches#create'
      get '/recipes/:recipe_id', to: 'recipes#show'
    end
  end
end
