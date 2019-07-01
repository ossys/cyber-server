Rails.application.routes.draw do
  namespace :api do
    resources :nodes, only: %i[index show]
    resources :configs, only: %i[index show]
  end

  post '/api/users', to: 'users#create'
  post '/api/sign_in', to: 'sessions#create'
  get '/jwt-test', to: 'users#test'

  get '/test', to: 'os_query#test'
  post '/enroll', to: 'os_query#enroll'
  post '/config', to: 'os_query#osq_config'
end
