# frozen_string_literal: true

module FrontendApi
  class AuthController < FrontendApplicationController
    include RenderHelper

    def create
      user = User.find_by(email: params[:email])
      render jsonapi_errors: 'User not found', status: 404 && return if user.nil?

      if user.authenticate(session_params[:password])
        jwt = Auth.issue(user: user.id)
        response.headers['HTTP_AUTHORIZATION'] = jwt
        resp = ObjectResponse.new(jwt)

        render jsonapi: resp
      else
        render jsonapi_errors: 'Invalid login', status: 400
      end
    end

    private

    def session_params
      params.permit(:email, :password)
    end

    def respond_with(resource, _opts = {})
      render json: resource
    end
  end
end
