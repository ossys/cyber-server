module OsQuery
  module Ingest
    class UsbLogsService
      def initialize(node_id, log)
        @node_id = node_id
        @log = log
      end

      def execute
        columns = @log['columns']

        usb_log = ::Frontend::UsbLog.new(
          node_id: @node_id,
          action: @log['action'],
          unixtime: @log['unixTime'],
          usb_class: columns['class'],
          subclass: columns['subclass'],
          model: columns['model'],
          model_id: columns['model_id'],
          protocol: columns['protocol'],
          removable: columns['removable'],
          serial: columns['serial'],
          usb_port: columns['usb_port'],
          usb_address: columns['usb_address'],
          vendor: columns['vendor'],
          vendor_id: columns['vendor_id'],
          version: columns['version'],
        )

        usb_log.save!
      end
    end
  end
end
