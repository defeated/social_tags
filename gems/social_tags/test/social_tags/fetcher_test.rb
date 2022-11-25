# frozen_string_literal: true

require "test_helper"

class TestConnectionFactory < SocialTags::Fetcher::FaradayConnectionFactory
  def self.build(adapter: :test)
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("https://example.com") { |env| [200, {}, "<html>"] }

    super adapter: [adapter, stubs]
  end
end

describe SocialTags::Fetcher do
  it "scrapes html for a url" do
    fetcher = SocialTags::Fetcher.new(factory: TestConnectionFactory)
    actual = fetcher.fetch(url: "https://example.com").body
    expect(actual).must_equal "<html>"
  end
end
