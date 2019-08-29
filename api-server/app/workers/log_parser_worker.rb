class LogParserWorker
  include Sidekiq::Worker

  def perform(node_id, params)
    return if params['log_type'] == 'status'

    logs = params['data']
    logs.each do |log|
      name = log['name']

      case name
      when 'usb_logs'
        OsQuery::Ingest::UsbLogsService
          .new(node_id, log)
          .execute
      when 'network_addresses'
        OsQuery::Ingest::InterfaceAddressesService
          .new(node_id, log)
          .execute
      else
        puts "Unrecognized log query #{name}!"
      end
    end
  end
end
