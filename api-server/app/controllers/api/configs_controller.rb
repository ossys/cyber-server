module Api
  class ConfigsController < ApplicationController
    skip_before_action :authenticate

    def index
      configs = Config.all
      render :json => { :data => configs }
    end

    def show
      config = Config.find(params[:id])
      render :json => { :data => config }
    end

    def create
      config = Config.new(config_params)
      config.save
      render_resource(config)
    end

    def update
      config = Config.update(params[:id], config_params)
      config.save
      render_resource(config)
    end

    def destroy
      # cannot delete the default config
      return render status: 400 if params[:id] == '1'

      if config = Config.find_by(id: params[:id])
        config.destroy
        render status: 200
      else
        render status: 404
      end
    end

    private

    def config_params
      params.require(:config).permit(:name, :data => {})
    end
  end
end
