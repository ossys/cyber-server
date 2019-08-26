# frozen_string_literal: true

module Frontend
  class QueriesController < FrontendApplicationController
    wrap_parameters :query_list

    def index
      queries = Query.all
      render_resource(queries)
    end

    def show
      query = Query.find(params[:id])
      render_resource(query)
    end

    def search
      queries = Query.where(ad_hoc_query_id: query_params[:ad_hoc_query_ids])
      rende_resource(query)
    end

    def create
      query = Query.new(query_params)

      if query.save
        render_resource(query)
      else
        validation_error(query)
      end
    end

    private

    def query_params
      params.require(:query_list).permit(:name, :body, ad_hoc_query_ids: [])
    end
  end
end
