class SessionsController < ApplicationController
  before_action { authorize :session }

  def new
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
