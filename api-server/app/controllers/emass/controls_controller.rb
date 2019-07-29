module EmassApi
  class ControlsController < EmassApplicationController
    include EmassRenderHelper

    # params ->
    # acronyms : string ex) AC-3,PM-6
    def index
      data = [
        {"systemId": params[:id], "name": "AC-1" },
        {"systemId": params[:id].to_i + 1, "name": "AC-2" }
      ]

      render_data(data)
    end

    def update
      render_data(controls_params)
    end

    private

    def controls_params
      json = params.delete(:_json) if params[:_json]
      params.permit(:id).tap do |whitelisted|
        whitelisted[:_json] = json.permit!
      end
    end
  end
end
