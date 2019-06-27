module Api
  class NodesController < ApplicationController
    def index
      @nodes = Node.all
      render :json => { :data => @nodes }
    end

    def show
      @node = Node.find(params[:id])
      render :json => { :data => @node }
    end
  end
end
