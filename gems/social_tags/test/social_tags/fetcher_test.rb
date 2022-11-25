# frozen_string_literal: true

require "test_helper"

describe SocialTags::Fetcher do
  it "scrapes html for a url" do
    actual = SocialTags::Fetcher.new.fetch(url: "https://example.com").body
    expect(actual).must_equal "<html>"
  end
end
