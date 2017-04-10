class User < ApplicationRecord
  has_many :logins
  has_many :sites, through: :logins

  before_save :downcase_email
  before_create :assign_auth_digest

  has_secure_password

  EMAIL_REGEX = /\A[\w+-]+(\.[\w-]+)*@[a-z\d-]+(\.[a-z\d-]+)*(\.[a-z]{2,4})\z/i

  validates :first_name, :last_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 50 },
    uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

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

  def publish_changes
    PublishUserChangesJob.perform_later(self)
  end

  def info
    { first_name: self.first_name, last_name: self.last_name, email: self.email }
  end

  private

    def downcase_email
      email.downcase!
    end

    def assign_auth_digest
      self.auth_digest = self.class.digest(self.class.new_token)
    end
end