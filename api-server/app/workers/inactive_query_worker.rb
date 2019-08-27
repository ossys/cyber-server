# Marks adhoc queries as timed_out if they're older
# than 1 minute.
class InactiveQueryWorker
  include Sidekiq::Worker

  def perform(*args)
    if (timed_out_queries = AdHocQuery.timed_out)
      timed_out_queries
        .in_batches
        .update_all(timed_out: true)
    end
  end
end
