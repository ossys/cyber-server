# frozen_string_literal: true

module Emass
  class PoamController < EmassApplicationController
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

    def poam_params
      params.permit(:id)
    end
  end
end
