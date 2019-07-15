# frozen_string_literal: true

module FrontendApi
  class NodesController < FrontendApplicationController
    def index
      @nodes = Node.all
      render json: { data: @nodes }
    end

    def show
      @node = Node.find(params[:id])
      render json: { data: @node }
    end
  end
end
