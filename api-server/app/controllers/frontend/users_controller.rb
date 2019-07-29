# frozen_string_literal: true

module Frontend
  class UsersController < FrontendApplicationController
    before_action :authenticate, except: %i[create]

    def create
      user = User.new(user_params)

      if user.valid? && user.save
        return render jsonapi: user, status: 201
      else
        return render jsonapi_errors: user.errors, status: 400
      end
    end

    def update; end

    def destroy; end

    def test
      render_resource(current_user)
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
