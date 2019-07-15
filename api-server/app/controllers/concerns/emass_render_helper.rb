# frozen_string_literal: true

module EmassApi
  module EmassRenderHelper
    DEFAULT_OPTS = { status: 200 }.freeze
    DEFAULT_ERR_OPTS = { status: 400 }.freeze

    def render_data(data, opts = DEFAULT_OPTS)
      meta = Meta.new(code: opts[:status])
      response = ApiResponse.new(meta: meta, data: data)

      render json: response, status: opts[:status]
    end

    # error -> String
    def render_error(error, opts = DEFAULT_ERR_OPTS)
      meta = Meta.new(code: opts[:status], errorMessage: error)
      response = ApiError.new(meta: meta)

      render json: response, status: opts[:status]
    end
  end
end
