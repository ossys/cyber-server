# frozen_string_literal: true

module Frontend
  class AdHocQueryListsController < FrontendApplicationController
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
      return render status: 400 unless query_list

      query_list.save
      render_resource(query_list)
    end

    private

    def query_params
      params.require(:query_list).permit(nodes: [], queries: %i[name body])
    end
  end
end
