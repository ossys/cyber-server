require 'json'

if Config.first == nil
  file = File.read(File.expand_path('../osquery.example.conf', __FILE__))
  default_config = JSON.parse(file)

  conf = Config.new
  conf.name = 'Default'
  conf.data = default_config
  conf.save!
end
