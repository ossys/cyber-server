# frozen_string_literal: true

module RenderHelper
  DEFAULT_OPTS = { status: 200 }.freeze

  def maybe_render_resource(resource, opts = DEFAULT_OPTS)
    if resource
      render_resource(resource, opts)
    else
      render_404(opts)
    end
  end

  def render_resource(resource, opts = DEFAULT_OPTS)
    response = opts.merge(json: { data: resource })

    if no_errors?(resource)
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

  def render_error(error, opts = {})
    render_errors([error], opts)
  end

  # -> { errors: ['', ''] }
  def render_errors(error_list, opts = {})
    opts[:status] = 400 unless opts[:status]
    opts[:json] = { errors: error_list }

    render opts
  end

  def render_404(opts = {})
    response = opts.merge(status: 404)
    render response
  end

  def no_errors?(resource)
    if resource.respond_to?('each')
      resource.all? { |r| r.errors.empty? }
    else
      resource.errors.empty?
    end
  end
end
