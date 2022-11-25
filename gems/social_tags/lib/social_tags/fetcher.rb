require "faraday"
require "faraday/follow_redirects"

module SocialTags
  class Fetcher
    def initialize(factory: FaradayConnectionFactory)
      @connection = factory.build
    end

    def fetch(url:)
      @connection.get(url)
    end

    private

    class FaradayConnectionFactory
      USER_AGENT = "SocialTags LinkBot/1.0".freeze

      def self.build()
        Faraday.new headers: {user_agent: USER_AGENT} do |conn|
          conn.response :follow_redirects, standards_compliant: true, limit: 5
        end
      end
    end

  end
end
