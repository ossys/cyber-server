# frozen_string_literal: true

class AdHocQuery
  # run from the osquery attack adapter
  def self.run(node_key, query_name, query_body)
    start_time = Time.now
    timeout_time = Time.now + 30.seconds

    query_list = AdHocQueryList.from_query(node_key, query_name, query_body)
    return "Error: Does node #{node_key} exist?" if query_list.nil?
    return "Error: Unable to save query due to: #{query_list.errors}" unless query_list.save!

    result = ''
    loop do
      return "Error: Timed out- a response was not received from node #{node_key} in time." if Time.now > timeout_time

      sleep 1.second

      if query_result = AdHocQueryResult.last_result_for_node(node_key, start_time)
        result = query_result.data
        break
      else
        next
      end
    end

    result
  end
end
