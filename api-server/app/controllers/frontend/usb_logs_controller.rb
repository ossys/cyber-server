module Frontend
  class UsbLogsController < FrontendApplicationController
    def index
      logs = Node
        .find(params[:id])
        .usb_logs
        .order(created_at: :asc)

      render status: 200, json: { data: logs }
    end
  end
end
