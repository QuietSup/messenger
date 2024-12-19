class ApplicationController < ActionController::API
  def jwt_encode(user)
    JWT.encode({ id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')
  end

  def jwt_decode
    token = request.headers['Authorization']&.split(" ").first
    return nil unless token
    begin
      JWT.decode(token, Rails.application.credentials.secret_key_base, false, { algorithm: 'HS256' }).first["id"]
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    @user ||= User.find_by_id jwt_decode
  end
end
