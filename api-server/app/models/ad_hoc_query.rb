class AdHocQuery
  # run from the osquery attack adapter
  def self.run(node_key, query_name, query_body)
    start_time = Time.now
    timeout_time = Time.now + 30.seconds

    query_list = AdHocQueryList.from_query(node_key, query_name, query_body)
    return "Error: Does node #{node_key} exist?" if query_list.nil?
    return "Error: Unable to save query due to: #{query_list.errors.to_s}" unless query_list.save!

    result = ""
    loop do
      return "Error: Timed out- a response was not received from node #{node_key} in time." if Time.now > timeout_time
      sleep 1.second

      query_result = AdHocQueryResult.where(node_key: node_key).limit(1).first

      next if query_result.nil?
      next if query_result.created_at < start_time

      if query_result.created_at > start_time
        result = query_result.data
        break
      end
    end
  end
end
