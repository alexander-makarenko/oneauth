class UserPolicy < ApplicationPolicy
  def create?
    !signed_in?
  end

  def show?
    signed_in?
  end

  def update?
    signed_in?
  end

  def index?
    admin?
  end

  def authenticate_remote?
    true
  end

  def provide_info?
    true
  end
end
