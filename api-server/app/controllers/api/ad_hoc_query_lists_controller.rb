module Api
  class AdHocQueryListsController < ApplicationController
    skip_before_action :authenticate
    wrap_parameters :query_list

    def index
      query_lists = AdHocQueryList.all
      render_resource query_lists
    end

    def show
      query_list = AdHocQueryList.find(params[:id])
      render_resource(query_list)
    end

    def create
      query_list = AdHocQueryList.new(query_params)

      if query_list.save
        render_resource query_list
      else
        validation_error(query_list)
      end
    end

    def create_manual
      query_list = AdHocQueryList.build(query_params)

      if query_list.save
        render json: query_list, status: 201
      else
        validation_error(query_list)
      end
    end

    private

    def query_params
      params.require(:query_list).permit(nodes: [{}], queries: [:name, :query])
    end
  end
end
