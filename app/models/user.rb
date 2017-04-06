class User < ApplicationRecord
  attr_accessor :skip_password_validation
  has_secure_password

  before_save :downcase_email
  before_create :assign_auth_digest

  EMAIL_REGEX = /\A[\w+-]+(\.[\w-]+)*@[a-z\d-]+(\.[a-z\d-]+)*(\.[a-z]{2,4})\z/i

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  validates :email,      presence: true, length: { maximum: 50 },
                         uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  

  class << self
    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def auth_token
    @auth_token || (self.auth_token = self.class.new_token)
  end

  def auth_token=(token)
    @auth_token = token
    self.auth_digest = self.class.digest(token)
    save(validate: false) unless new_record?
    token
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

    def downcase_email
      email.downcase!
    end

    def assign_auth_digest
      self.auth_digest = self.class.digest(self.class.new_token)
    end
end
