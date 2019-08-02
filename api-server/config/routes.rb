# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  scope :api do
    namespace :slack do
      post '/event', to: 'slack#event'
    end

    namespace :frontend do
      resources :nodes, only: %i[index show]
      resources :configs, only: %i[index show create update destroy]
      resources :ad_hoc_query_lists, only: %i[index create show]
      post '/ad_hoc_query_lists/manual', to: 'ad_hoc_query_lists#create_manual'
      post :users, to: 'users#create'
      post :token, to: 'auth#create'

      #get :webhook, to: 'attacks#webhook'

      scope :attacks do
        get '/', to: 'attacks#index'
        get '/:file_name', to: 'attacks#show'
        post '/', to: 'attacks#create'
        put '/', to: 'attacks#update'
        delete '/', to: 'attacks#destroy'

        post '/run', to: 'attacks#run'
      end

      scope :tests do
        post '/run', to: 'tests#run'
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
