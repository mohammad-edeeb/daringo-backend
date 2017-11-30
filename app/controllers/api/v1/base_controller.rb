class Api::V1::BaseController < ActionController::Base
  include Api::V1::AuthenticationHelper
  layout 'base'

  # rescue_from Exception, with: :error_occurred

  private

  def render_unprocessable(message)
    @message = message
    render 'api/v1/empty', status: :unprocessable_entity
  end

  def render_empty_success
    render 'api/v1/empty', status: :ok
  end

  # def error_occurred(exception)
  #   @message = exception.message
  #   # Rails.logger.error("API ERROR: error => #{@message}, stack trace => #{exception.backtrace}")
  #   render 'api/v1/empty', status: :internal_server_error
  # end

end
