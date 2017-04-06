class StaticPagesController < ApplicationController
  def home
    redirect_to account_path if signed_in?
  end
end
