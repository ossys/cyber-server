# frozen_string_literal: true

Rails.application.configure do
  config.lograge.base_controller_class = 'ActionController::API'
  config.lograge.custom_options = lambda do |_event|
    { time: Time.now }
  end
end
