class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :helper_list

  def helper_list
    @address = params[:address_input]
    @helpers = User.where(role: "helper")
    if params[:address_input].present?
      @near_helpers = @helpers.near(params[:address_input], 10)
      if params[:diploma] == "Certifications"
        @near_helpers = @helpers.near(params[:address_input], 10)
      elsif params[:diploma].present?
        @near_helpers = @near_helpers.where(diploma: params[:diploma])
      else
        @near_helpers
      end
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
