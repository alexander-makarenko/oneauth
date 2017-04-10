class SitePolicy < ApplicationPolicy
  def create?
    admin?
  end

  def show?
    admin?
  end

  def update?
    admin?
  end

  def index?
    admin?
  end
end
