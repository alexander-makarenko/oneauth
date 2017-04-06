class UsersController < ApplicationController

  before_action { authorize User }

  def index
    @users = User.order(:id).paginate(page: params[:page])
  end

  def show
    if params[:id] && current_user.admin?
      @user = User.find_by(id: params[:id])
      redirect_to account_path if @user == current_user
      redirect_to root_path unless @user
    else
      @user = current_user
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    if params[:id] && current_user.admin?
      @user = User.find_by(id: params[:id])
      redirect_to settings_path if @user == current_user
      redirect_to root_path unless @user
    else
      @user = current_user
    end
  end
  
  def update
    if params[:id] && current_user.admin?
      @user = User.find_by(id: params[:id])      
    else
      @user = current_user
    end

    if @user.update_attributes(user_params)
      redirect_to @user, success: 'Settings updated'
    else
      render :edit
    end
  end

  # def destroy
  # end

  private
  
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
    end

    def user_not_authorized
      redirect_to root_path
    end
end