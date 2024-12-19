class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new user_params
    return render json: @user.errors unless @user.save

    render json: { data: { user: @user, token: jwt_encode(@user) } }
  end

  private

  def user_params
    params.expect user: %i[username password]
  end
end
