# frozen_string_literal: true

require 'json'

if Config.first.nil?
  file = File.read(File.expand_path('osquery.example.conf', __dir__))
  default_config = JSON.parse(file)

  config = Config.new
  config.name = 'Default'
  config.data = default_config
  config.save!

  n = Node.new(node_key: 'test', config: config)
  n.save!

  q = Query.new(name: "os version name", body: "select name from os_version;")
  q.save!
end
