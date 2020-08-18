class ProfilesController < ApplicationController
  def helper_list
    session[:address_input] = params[:address_input]

    if session[:address_input].present?
      @helpers = User.where(role: "helper")
      @helpers.near(session[:address_input], 10)
    else
      @helpers.all
    end
  end

  private

  def set_user
    @helper = User.find(params[:id])
    authorize @helper
  end
end
