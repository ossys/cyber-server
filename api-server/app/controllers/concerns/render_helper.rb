# frozen_string_literal: true

module RenderHelper
  DEFAULT_OPTS = { status: 200 }

  def maybe_render_resource(resource, opts = DEFAULT_OPTS)
    if resource
      render_resource(resource, opts)
    else
      render_404(opts)
    end
  end

  def render_resource(resource, opts = DEFAULT_OPTS)
    response = opts.merge({ json: { data: resource } })

    if has_errors?(resource)
      render response
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

  def render_404(opts)
    response = opts.merge(status: 404)
    render response
  end

  def has_errors?(resource)
    if resource.respond_to?('each')
      resource.all?{ |r| r.errors.empty? }
    else
      resource.errors.empty?
    end
  end
end
