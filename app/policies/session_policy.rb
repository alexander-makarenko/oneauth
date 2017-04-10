class SessionPolicy < ApplicationPolicy
  def new_remote?
    true
  end

  def create?
    !signed_in?
  end

  def destroy?
    signed_in?
  end
end
