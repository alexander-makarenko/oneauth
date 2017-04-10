class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid_url?(value)
      record.errors[attribute] << (options[:message] || "is not a valid HTTP URL")
    end
  end

  private
  
    def valid_url?(str)
      uri = URI.parse(str)
      uri.kind_of?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end
end

class Site < ApplicationRecord
  has_many :logins
  has_many :users, through: :logins

  before_create :assign_secret_key

  validates :name, presence: true, length: { maximum: 60 }
  validates :domain, :user_update_callback, :auth_token_callback, url: true

  def send_auth_token(auth_token)
    SendUserAuthTokenJob.perform_later(self, auth_token)    
  end

  private

    def assign_secret_key
      self.secret_key = self.class.digest(self.class.new_token)
    end
end