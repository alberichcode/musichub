class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  include PublicActivity::StoreController

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_user
    @user = current_user
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform that action."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
