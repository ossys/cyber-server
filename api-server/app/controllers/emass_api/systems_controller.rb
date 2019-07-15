module EmassApi
  class SystemsController < EmassApplicationController
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
    def index
      data = [
        {"systemId": 64},
        {"systemId": 65}
      ]
      render_data(data)
    end

    def show
      data = [ {"systemId": 64} ]
      render_data(data)
    end

    def test_results
      render_data('TODO')
    end

    private

    def systems_params
      params.permit(:id)
    end
  end
end
