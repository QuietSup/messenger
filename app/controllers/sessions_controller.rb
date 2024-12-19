class SessionsController < ApplicationController
  def me
    return head :unauthorized unless  current_user
    render json: current_user
  end
end
