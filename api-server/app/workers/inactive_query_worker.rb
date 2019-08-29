# Marks adhoc queries as timed_out if they're older
# than 1 minute.
class InactiveQueryWorker
  include Sidekiq::Worker

  def perform(*args)
    timed_out_queries = ::Frontend::AdHocQuery.timed_out
    return if timed_out_queries.nil? || timed_out_queries.empty?

    timed_out_queries
      .in_batches
      .update_all(timed_out: true)
  end
end
