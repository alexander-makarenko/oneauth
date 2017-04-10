class Login < ApplicationRecord
  belongs_to :user
  belongs_to :site

  before_create :assign_auth_token

  private

    def assign_auth_token
      self.auth_token = self.class.digest(self.class.new_token)
    end
end