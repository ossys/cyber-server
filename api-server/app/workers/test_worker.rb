class TestWorker
  include Sidekiq::Worker

  def perform(who, message)
    logger.info("Message from #{who} is #{message}")
  end
end
