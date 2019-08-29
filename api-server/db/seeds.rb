# frozen_string_literal: true

require 'json'

if Config.find_by(id: 1).nil?
  file = File.read(File.expand_path('./default-linux.json', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.id = 1
  config.name = 'Default Linux'
  config.data = default_config
  config.save!
end

if Config.find_by(id: 2).nil?
  file = File.read(File.expand_path('./default-win.json', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.id = 2
  config.name = 'Default Linux'
  config.data = default_config
  config.save!
end

if Config.find_by(id: 3).nil?
  file = File.read(File.expand_path('./default-linux.json', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.id = 3
  config.name = 'Reserved for a default OSX Config'
  config.data = default_config
  config.save!
end

if Config.find_by(id: 4).nil?
  file = File.read(File.expand_path('./default-linux.json', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.id = 4
  config.name = 'Reserved for a default BSD Config'
  config.data = default_config
  config.save!
end
