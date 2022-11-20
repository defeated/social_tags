# frozen_string_literal: true

require "test_helper"

class TestConnectionFactory
  def self.build(cache: nil)
    mock.expect(:get, mock.expect(:body, "<html>"), [String])
  end
end

describe SocialTags::Fetcher do
  before do
    @url = "https://example.com"
    @fetcher = SocialTags::Fetcher.new factory: TestConnectionFactory
  end

  it "scrapes html for a url" do
    actual = @fetcher.fetch(url: @url).body
    expect(actual).must_equal "<html>"
  end
end
