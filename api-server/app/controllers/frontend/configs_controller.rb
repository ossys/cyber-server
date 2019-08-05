# frozen_string_literal: true

module Frontend
  class ConfigsController < FrontendApplicationController
    include RenderHelper

    def index
      configs = Config.all
      render json: { data: configs }
    end

    def show
      config = Config.find_by(id: params[:id])
      maybe_render_resource(config)
    end

    def create
      config = Config.new(config_params)
      config.save
      render_resource(config, status: 201)
    end

    def update
      config = Config.update(params[:id], config_params)
      config.save
      render_resource(config, status: 200)
    end

    def destroy
      # cannot delete the default config
      return render status: 400 if params[:id] == '1'

      if (config = Config.find_by(id: params[:id]))
        config.destroy
        render status: 204
      else
        render status: 404
      end
    end

    private

    def config_params
      params.permit(:name, data: {})
    end
  end
end
