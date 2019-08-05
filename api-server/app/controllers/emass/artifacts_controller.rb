# frozen_string_literal: true

module Emass
  class ArtifactsController < EmassApplicationController
    include EmassRenderHelper

    def index
      render_data('TODO')
    end

    def create
      render_data('TODO', status: 201)
    end

    def delete
      render_data('TODO', status: 204)
    end

    def export
      render_data('TODO')
    end

    private

    def artifacts_params
      params.permit(:id)
    end
  end
end
