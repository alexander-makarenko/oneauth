class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end