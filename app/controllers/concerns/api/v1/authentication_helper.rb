module Api::V1::AuthenticationHelper extend ActiveSupport::Concern

  def authenticate_api_user!
    return true if get_user_by_token
    unauthorized
  end

  def current_user
    user = instance_variable_get("@_current_user")
    return user if user.present?
    instance_variable_set("@_current_user", get_user_by_token)
  end

  private

  def get_user_by_token
    token = get_token_from_header
    User.find_by(token: token)
  end

  def unauthorized
    @message = 'Authentication failed, invalid authentication token'
    respond_to do |format|
      format.json { render 'api/v1/empty', status: :unauthorized }
    end
  end

  def get_token_from_header
    token = nil
    if request.headers["Authorization"].present?
      token = request.headers["Authorization"]
    end
    token
  end

end
