class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :role, :description, :price, :mobile_number, :diploma, :photo, :address2, :pathology, :handicap, :link, :family_last_name, :family_first_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :role, :description, :price, :photo, :pathology, :address2, :handicap])
  end

  def default_url_options
  { host: ENV["www.sekoya.me"] || "localhost:3000" }
  end
end
