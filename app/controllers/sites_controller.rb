class SitesController < ApplicationController
  before_action { authorize Site }

  def index
    @sites = Site.order(:id).paginate(page: params[:page])
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to sites_path, success: 'Site added'
    else
      render :new
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])    
    if @site.update_attributes(site_params)
      redirect_to sites_path, success: 'Site updated'
    else
      render :edit
    end
  end

  # def destroy
  # end

  private
  
    def site_params
      params.require(:site).permit(
        :name,
        :domain,
        :user_update_callback,
        :auth_token_callback
      )
    end

    def user_not_authorized
      redirect_to root_path
    end
end