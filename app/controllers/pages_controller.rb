class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @address = ""
    @address = current_user.address if user_signed_in?
  end
end
