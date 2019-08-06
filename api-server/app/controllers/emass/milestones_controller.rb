# frozen_string_literal: true

module Emass
  class MilestonesController < EmassApplicationController
    include EmassRenderHelper

    def index
      render_data(['TODO'])
    end

    def show
      render_data(['TODO'])
    end

    def create
      render_data(['TODO'], status: 201)
    end

    def update
      render_data(['TODO'], status: 201)
    end

    def destroy
      render_data(['TODO'], status: 204)
    end

    private

    def milestone_params
      params.permit(:id)
    end
  end
end
