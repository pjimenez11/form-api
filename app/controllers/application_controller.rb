class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def respond_to_on_destroy
    token = extract_token_from_headers

    if token
      jwt_payload = decode_token(token)
      user_id = jwt_payload['sub']
      current_user = User.find_by(id: user_id)

      if current_user
        current_user.update_column(:authentication_token, nil)

        render json: {
          status: { code: 200, message: 'User signed out successfully' }
        }
      else
        render json: {
          status: { code: 401, message: 'User not found or has no active session' }
        }, status: :unauthorized
      end
    else
      render json: {
        status: { code: 401, message: 'Invalid or missing token' }
      }, status: :unauthorized
    end
  end

  private

  def extract_token_from_headers
    request.headers['Authorization']&.split(' ')&.last
  end

  def decode_token(token)
    begin
      JWT.decode(token, Rails.application.credentials.fetch(:secret_key_base)).first
    rescue JWT::DecodeError
      nil
    end
  end
end

