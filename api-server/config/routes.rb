# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  namespace :frontend_api do
    resources :nodes, only: %i[index show]
    resources :configs, only: %i[index show create update destroy]
    resources :ad_hoc_query_lists, only: %i[index create show]
    post '/ad_hoc_query_lists/manual', to: 'ad_hoc_query_lists#create_manual'
    post 'users', to: 'users#create'
    post 'token', to: 'auth#create'
  end

  namespace :emass_api, path: 'api' do
    get '/', to: 'emass#status'
    get :register, to: 'emass#register'

    scope :systems, path: 'systems' do
      get '/', to: 'systems#get'
      get '/:id/controls', to: 'systems#get_controls'
      put '/:id/controls', to: 'systems#put_controls'
    end
  end

  namespace :os_query_api, path: '/' do
    get '/test', to: 'os_query#test'

    post '/enroll', to: 'os_query#enroll'
    post '/config', to: 'os_query#osq_config'
    post '/log', to: 'os_query#log'

    post '/distributed_read', to: 'os_query#dist_read'
    post '/distributed_write', to: 'os_query#dist_write'
  end
end
