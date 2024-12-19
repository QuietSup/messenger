class ApplicationController < ActionController::API
  def jwt_encode(user)
    JWT.encode({ id: user.id }, secret, 'HS256')
  end

  def jwt_decode
    token = request.headers['Authorization']&.split&.last
    return nil unless token
    begin
      JWT.decode(token, secret, false, { algorithm: 'HS256' }).first["id"]
    rescue JWT::DecodeError
      nil
    end
  end

  def secret
    Rails.application.credentials.secret_key_base
  end

  def current_user
    @user ||= User.find_by_id jwt_decode
  end
end
