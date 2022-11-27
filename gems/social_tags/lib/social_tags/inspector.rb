module SocialTags
  class Inspector
    Page = Struct.new("Page", :success, :tags, :error, keyword_init: true) do
      alias_method :success?, :success
    end

    def initialize(url:)
      @url = url
    end

    def inspect
      fetched = Fetcher.new.fetch(url: @url).body
      tags = Parser.new(html: fetched).parse
    rescue StandardError => error
    ensure
      return Page.new(success: !error, tags: Hash(tags), error: error&.message)
    end
  end
end
