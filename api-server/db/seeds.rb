require 'json'

if Config.first == nil
  file = File.read(File.expand_path('../osquery.example.conf', __FILE__))
  default_config = JSON.parse(file)

  config = Config.new
  config.name = 'Default'
  config.data = default_config
  config.save!

  n = Node.new(key: 'test', config: config)
  n.save!
end
