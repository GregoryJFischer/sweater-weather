Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :sessions, only: [:create]

      get '/forecast', to: 'forecast#index'
      get '/backgrounds', to: 'backgrounds#index'
      post '/road_trip', to: 'road_trips#index'
    end
  end
end
