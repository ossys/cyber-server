module EmassApi
  class SystemsController < EmassApplicationController
    #wrap_parameters :controls, only: [:put_controls], format: [:json]

    # params ->
    # includePackage : boolean
    # registrationType : list[string], comma separated
    # ditprId : string, ex) 93054
    # coamsId : string, ex) 30498
    # policy: string enum from
    # # diacap, rmf, reporting
    # # rmf is default if none passed
    # includeDitprMetrics : boolean
    # # can only be used in conjunction with
    # # `registrationType` or `policy`
    #
    # if :id is passed ->
    # only these params can be run
    # includePackage : boolean
    # policy: string enum from
    # # diacap, rmf, reporting
    # # rmf is default if none passed
    def get
      data = [
        {"systemId": 64},
        {"systemId": 65}
      ]
      render_data(data)
    end

    # params ->
    # acronyms : string ex) AC-3,PM-6
    def get_controls
      data = [
        {"systemId": systems_params[:id], "name": "AC-1" },
        {"systemId": systems_params[:id].to_i + 1, "name": "AC-2" }
      ]
      render_data(data)
    end

    def put_controls
      render_data(controls_params)
    end

    private

    def systems_params
      params.permit(:id)
    end

    def controls_params
      json = params.delete(:_json) if params[:_json]
      params.permit(:id).tap do |whitelisted|
        whitelisted[:_json] = json.permit!
      end
    end
  end
end
