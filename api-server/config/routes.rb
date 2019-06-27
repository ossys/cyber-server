Rails.application.routes.draw do
  namespace :api do
    resources :nodes, only: %i[index show]
    resources :configs, only: %i[index show]
  end

  get '/test', to: 'os_query#test'
  post '/enroll', to: 'os_query#enroll'
  post '/config', to: 'os_query#osq_config'
end
