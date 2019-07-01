module RenderHelper
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
