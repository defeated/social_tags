require "faraday"
require "faraday/follow_redirects"

module SocialTags
  class Connection
    USER_AGENT = "SocialTags LinkBot/1.0".freeze

    def self.build(adapter: nil)
      Faraday.new headers: {user_agent: USER_AGENT} do |conn|
        conn.adapter(*adapter)
        conn.response :logger
        conn.response :raise_error
        conn.response :follow_redirects, standards_compliant: true, limit: 5
      end
    end
  end
end
