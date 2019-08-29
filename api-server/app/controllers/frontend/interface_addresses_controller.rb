module Frontend
  class InterfaceAddressesController < FrontendApplicationController
    def index
      interface_addresses = Node
        .find(params[:id])
        .interface_addresses

      render status: 200, json: { data: interface_addresses }
    end
  end
end
