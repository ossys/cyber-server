module RenderHelper
  def render_resource(resource, status = 200)
    if has_errors?(resource)
      render json: { data: resource }, status: status
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

  def has_errors?(resource)
    if resource.respond_to?('each')
      resource.all?{ |r| r.errors.empty? }
    else
      resource.errors.empty?
    end
  end
end
