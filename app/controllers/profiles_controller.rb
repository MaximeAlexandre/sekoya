class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :helper_list

  def helper_list
    session[:address_input] = params[:address_input]

    if session[:address_input].present?
      @helpers = User.where(role: "helper")
      @helpers.near(session[:address_input], 10)
    else
      redirect_to '#'
    end
  end

  private

  def set_user
    @helper = User.find(params[:id])
    authorize @helper
  end
end
