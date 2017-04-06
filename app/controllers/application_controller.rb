class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pundit

  add_flash_types :success, :info, :warning, :danger

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  private

    def user_not_authorized
      redirect_to root_path, danger: not_authorized_message
    end

    def not_authorized_message
      t("#{controller_name.sub(/s\z/, '')}.#{action_name}", scope: 'pundit', default: :default)
    end
end