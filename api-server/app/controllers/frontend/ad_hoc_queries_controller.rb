# frozen_string_literal: true

module Frontend
  class AdHocQueriesController < FrontendApplicationController
    wrap_parameters :query_list

    def index
      query = AdHocQuery.all
      render_resource(query)
    end

    def show
      query = AdHocQuery.find(params[:id])
      render_resource(query)
    end

    def create
      query = AdHocQuery.build(query_params)
      return render_error("Node not found!") unless query

      if query.save
        render_resource(query)
      else
        validation_error(query)
      end
    end

    def destroy
      if (query = AdHocQuery.find_by(id: params[:id]))
        query.destroy
        render status: 204
      else
        render status: 404
      end
    end

    private

    def query_params
      params.require(:query_list).permit(nodes: [], queries: [:name, :body])
    end
  end
end
