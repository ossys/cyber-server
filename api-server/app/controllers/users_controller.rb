class UsersController < ApplicationController
  before_action :authenticate, except: %i[create]

  def create
    p params
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      validation_error(user)
    end
  end

  def update
  end

  def destroy
  end

  def test
    render_resource(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
