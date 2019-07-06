# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: params[:email])
    render_error('User not found', status: 404) && return if user.nil?

    if user.authenticate(session_params[:password])
      jwt = Auth.issue(user: user.id)
      response.headers['HTTP_AUTHORIZATION'] = jwt

      render json: { jwt: jwt }
    else
      render json: { status: 400 }
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
