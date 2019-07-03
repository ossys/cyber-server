# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'

    resources :nodes, only: %i[index show]
    resources :configs, only: %i[index show create update destroy]
    resources :ad_hoc_query_lists, only: %i[index create show]
    post '/ad_hoc_query_lists/manual', to: 'ad_hoc_query_lists#create_manual'
  end

  post '/api/users', to: 'users#create'
  post '/api/sign_in', to: 'sessions#create'
  get '/jwt_test', to: 'users#test'

  get '/test', to: 'os_query#test'

  post '/enroll', to: 'os_query#enroll'
  post '/config', to: 'os_query#osq_config'
  post '/log', to: 'os_query#log'

  post '/distributed_read', to: 'os_query#dist_read'
  post '/distributed_write', to: 'os_query#dist_write'
end
