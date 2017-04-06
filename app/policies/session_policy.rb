class SessionPolicy < ApplicationPolicy
  def create?
    !signed_in?
  end

  def destroy?
    signed_in?
  end
end
