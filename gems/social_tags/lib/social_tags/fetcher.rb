require "faraday"
require "faraday/http_cache"
require "faraday/follow_redirects"

module SocialTags
  class Fetcher
    def initialize(cache: nil, factory: FaradayConnectionFactory)
      @cache = cache
      @factory = factory
    end

    def fetch(url:)
      @factory.build(cache: @cache).get(url)
    end

    private

    class FaradayConnectionFactory
      USER_AGENT = "SocialTags LinkBot/1.0".freeze

      def self.build(cache:)
        Faraday.new headers: {user_agent: USER_AGENT} do |conn|
          conn.response :follow_redirects, standards_compliant: true, limit: 5
          conn.use :http_cache, store: cache
        end
      end
    end

  end
end
