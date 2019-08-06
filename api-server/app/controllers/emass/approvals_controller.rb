# frozen_string_literal: true

module Emass
  class ApprovalsController < EmassApplicationController
    include EmassRenderHelper

    def cac
      render_data('TODO')
    end

    def pac
      render_data('TODO')
    end

    private

    def approvals_params
      params.permit(:id)
    end
  end
end
