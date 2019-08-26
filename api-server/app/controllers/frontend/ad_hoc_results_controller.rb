module Frontend
  class AdHocResultsController < FrontendApplicationController
    def index
      results = AdHocResult.all
      render_resource(results)
    end

    def show
      result = AdHocResult.find(params[:id])
      render_resource(result)
    end

    def destroy
      if (result = AdHocResult.find_by(id: params[:id]))
        result.destroy
        render status: 204
      else
        render status: 404
      end
    end
  end
end
