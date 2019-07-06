# frozen_string_literal: true

module AuthHelper
  def logged_in?
    !!current_user
  end

  def current_user
    return unless auth_present?

    user = User.find(auth.first['data']['user'])
    @current_user ||= user if user
  end

  def authenticate
    render json: { error: 'unauthorized' }, status: 401 unless logged_in?
  end

  private

  def token
    request.env['HTTP_AUTHORIZATION'].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request
      .env
      .fetch('HTTP_AUTHORIZATION', '')
      .scan(/Bearer/)
      .flatten
      .first
  end
end
