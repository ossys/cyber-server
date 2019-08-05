# frozen_string_literal: true

module Frontend
  class RegistrationsController < FrontendApplicationController
    include RenderHelper

    def create
      user = User.new(register_params)

      if user.valid? && user.save
        render :jsonapi, user, status: 201
      else
        render :jsonapi_errors, user.errors
      end
    end

    private

    def register_params
      params.permit(:email, :password)
    end
  end
end
