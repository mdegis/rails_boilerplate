# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # to suppress the RubyMıne warning
  def current_user
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys:
        %i[username email password password_confirmation current_password])
  end
end
