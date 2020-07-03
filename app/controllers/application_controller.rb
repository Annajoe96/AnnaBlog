class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:firstname, :lastname])
  end

  def user_not_authorized
    flash[:error] = "You are not authorised to do this."
    redirect_to(request.referrer || root_path)
  end
end
