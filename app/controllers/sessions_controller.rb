class SessionsController < ApplicationController
  before_action { authorize :session }

  layout 'layouts/remote', only: :new_remote

  def new
  end

  def new_remote
    @callback_url = Site.find_by(domain: request.referrer).try(:auth_token_callback)
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    
    if user.try(:authenticate, params[:password])
      sign_in(user, params[:keep_signed_in])
      redirect_to account_path
    else
      flash.now[:danger] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

    def user_not_authorized
      redirect_to root_path
    end
end