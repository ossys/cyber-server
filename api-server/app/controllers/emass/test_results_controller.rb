# frozen_string_literal: true

module Emass
  class TestResultsController < EmassApplicationController
    include EmassRenderHelper

    # params ->
    # controlAcronyms : String, ex) "AC-3,PM-6"
    # ccis : String, ex) "000123,000069"
    # latestOnly : Boolean, ex) true/false
    def index
      data = [
        {
          systemId: 98,
          cci: '000001',
          control: 'PM-1',
          cci: '000073'
        },
        {
          systemId: 99,
          cci: '000002',
          control: 'PM-2',
          cci: '000074'
        }
      ]
      render_data(data)
    end

    def create
      render_data('TODO', status: 201)
    end

    private

    def test_results_params
      params.permit(:id)
    end
  end
end
