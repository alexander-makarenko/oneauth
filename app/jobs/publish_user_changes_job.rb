class PublishUserChangesJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.sites.each do |site|
      auth_token = Login.where(user_id: user.id, site_id: site.id).first.auth_token      
      data = { user: { auth_token: auth_token }.merge(user.info) }

      uri = URI.parse(site.user_update_callback)
      req = Net::HTTP::Patch.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    end
  end
end