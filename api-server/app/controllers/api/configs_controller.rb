module Api
  class ConfigsController < ApplicationController
    def index
      @configs = Config.all
      render :json => { :data => @configs }
    end

    def show
      @config = Config.find(params[:id])
      render :json => { :data => @config }
    end

    def new
    end

    def create
    end

    def update
    end

    def edit
    end

    def destroy
    end
  end
end
