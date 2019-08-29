module OsQuery
  module Ingest
    class InterfaceAddressesService
      def initialize(node_id, log)
        @node_id = node_id
        @log = log
      end

      def execute
        columns = @log['columns']

        address = ::Frontend::InterfaceAddress
          .find_or_initialize_by(
            node_id: @node_id, interface: columns['interface'], mask: columns['mask'])

        address.unixtime = @log['unixTime']
        address.address = columns['address']
        address.mask = columns['mask']
        address.broadcast = columns['broadcast']
        address.point_to_point = columns['point_to_point']
        address.interface_type = columns['type']

        address.save!
      end
    end
  end
end
