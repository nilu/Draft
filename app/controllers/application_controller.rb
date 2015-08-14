class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :api_status

  protected

  def api_status(status, success, message)
    @message = message
    @success = success
    @status  = status 
  end
end
