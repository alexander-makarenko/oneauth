class UsersController < ApplicationController

  before_action { authorize User }
  skip_before_action :verify_authenticity_token, only: [:authenticate_remote, :provide_info]

  def index
    @users = User.order(:id).paginate(page: params[:page])
  end

  def show
    return @user = current_user unless params[:id]
    if current_user.admin?
      @user = User.find(params[:id])
      redirect_to account_path if @user == current_user
    else
      raise Pundit::NotAuthorizedError
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
    return @user = current_user unless params[:id]
    if current_user.admin?
      @user = User.find(params[:id])
      redirect_to settings_path if @user == current_user
    else
      raise Pundit::NotAuthorizedError
    end
  end
  
  def update
    @user = params[:id] && current_user.admin? ? User.find(params[:id]) : current_user    
    if @user.update_attributes(user_params)
      @user.publish_changes
      redirect_to @user, success: 'Settings updated'
    else
      render :edit
    end
  end

  def authenticate_remote
    site = Site.find_by(secret_key: params[:secret_key])
    @user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

    if site && @user
      unless @login = Login.where(user_id: @user.id, site_id: site.id).first
        @login = Login.create(user_id: @user.id, site_id: site.id)
      end
      render json: { auth_token: @login.auth_token }
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def provide_info
    @user = Login.find_by(auth_token: params[:auth_token]).try(:user)
    if @user
      render json: @user.info
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  
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