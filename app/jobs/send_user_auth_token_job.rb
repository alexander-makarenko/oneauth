class SendUserAuthTokenJob < ApplicationJob
  queue_as :default

  def perform(site, auth_token)
    Net::HTTP.post_form(URI.parse(site.auth_token_callback), auth_token: auth_token)
  end
end