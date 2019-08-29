# frozen_string_literal: true

require 'json'

if Config.first.nil?
  file = File.read(File.expand_path('../../osqueryd/configs/default-linux.json', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.name = 'Default'
  config.data = default_config
  config.save!
end
