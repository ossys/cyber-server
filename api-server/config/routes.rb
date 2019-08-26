# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
  end

  scope :api do
    get :status, to: 'api#status'

    namespace :slack do
      post '/event', to: 'slack#event'
    end

    namespace :frontend do
      resources :nodes, only: %i[index show]
      resources :configs, only: %i[index show create update destroy]

      resources :ad_hoc_queries, only: %i[index create show destroy]
      resources :ad_hoc_results, only: %i[index show destroy]

      resources :queries, only: %i[index create show]
      post '/queries/search', to: 'queries#search'

      post :users, to: 'users#create'
      post :token, to: 'auth#create'

      #get :webhook, to: 'attacks#webhook'

      scope :attacks do
        post '/run', to: 'attacks#run'
        post '/run_manual', to: 'attacks#manual_run'
      end

      scope :attack_files do
        get '/', to: 'attack_files#index'
        get '/:file_name', to: 'attack_files#show'
        post '/', to: 'attack_files#create'
        put '/', to: 'attack_files#update'
        delete '/', to: 'attack_files#destroy'
      end
    end

    scope :emass do
      get '/', to: 'emass#status'
      get :register, to: 'emass#register'

      scope :systems, path: 'systems' do
        get '/', to: 'systems#index'
        get '/:id', to: 'systems#show'

        scope ':id/controls' do
          get '/', to: 'controls#index'
          put '/', to: 'controls#update'
        end

        scope ':id/testresults' do
          get '/', to: 'test_results#index'
          post '/', to: 'test_results#create'
        end

        scope ':id/poam' do
          get '/', to: 'poam#index'
          get '/:poam_id', to: 'poam#show'
          post '/', to: 'poam#create'
          put '/', to: 'poam#update'
          delete '/', to: 'poam#destroy'

          scope ':poam_id/milestones' do
            get '/', to: 'milestones#index'
            get '/:milestone_id', to: 'milestones#show'
            post '/', to: 'milestones#create'
            put '/', to: 'milestones#update'
            delete '/', to: 'milestones#destroy'
          end
        end

        get '/artifactsexport', to: 'artifacts#export'
        scope ':id/artifacts' do
          get '/', to: 'artifacts#index'
          post '/', to: 'artifacts#create'
          put '/', to: 'artifacts#update'
          delete '/', to: 'artifacts#delete'
        end

        scope ':id/approval' do
          get '/cac', to: 'approvals#cac'
          get '/pac', to: 'approvals#pac'
        end
      end
    end

    namespace :os_query, path: '/osquery' do
      get '/test', to: 'os_query#test'

      post '/enroll', to: 'os_query#enroll'
      post '/config', to: 'os_query#osq_config'
      post '/log', to: 'os_query#log'

      post '/distributed_read', to: 'os_query#dist_read'
      post '/distributed_write', to: 'os_query#dist_write'
    end
  end
end
