module SocialTags
  class Fetcher
    class << self
      attr_accessor :connection
    end
    self.connection = Connection

    def initialize
      @connection = self.class.connection.build
    end

    def fetch(url:)
      @connection.get(url)
    end
  end
end
