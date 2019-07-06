# frozen_string_literal: true

class RegistrationsController < ApplicationController
  respond_to :json
  wrap_parameters :user

  def create
    build_resource(register_params)

    resource.save
    render_resource(resource)
  end

  private

  def register_params
    params.require(:user).permit(:email, :password)
  end
end
