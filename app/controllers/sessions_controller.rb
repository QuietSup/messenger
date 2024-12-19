class SessionsController < ApplicationController
  def me
    return head :unauthorized unless  current_user
    render json: current_user
  end

  def create
    @user = User.find_by username: session_params[:username]
    return head :unauthorized unless @user.authenticate(session_params[:password])
    render json: { data: { user: @user, token: jwt_encode(@user) } }
  end

  private

  def session_params
    params.permit :username, :password
  end
end
