Rails.application.routes.draw do
  get '/test', to: 'api#test'
  post '/enroll', to: 'api#enroll'
  post '/config', to: 'api#osq_config'
end
