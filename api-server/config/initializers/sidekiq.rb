sidekiq_config = { url: ENV['JOB_WORKER_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

# cron jobs

Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml') if Sidekiq.server?
