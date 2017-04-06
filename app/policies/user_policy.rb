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

  private

    def admin?
      user.try(:admin?)
    end  
end
