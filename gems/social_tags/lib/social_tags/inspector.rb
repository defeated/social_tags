module SocialTags
  class Inspector
    Page = Struct.new("Page", :success, :tags, :error, keyword_init: true) do
      alias_method :success?, :success
    end

    def initialize(url:)
      @url = url
    end

    def inspect
      fetched = SocialTags::Fetcher.new.fetch(url: @url)
      tags = SocialTags::Parser.new(html: fetched.body).parse
    rescue StandardError => error
    ensure
      return Page.new(success: !error, tags: tags || {}, error: error&.message)
    end
  end
end
