# frozen_string_literal: true

require "test_helper"

describe SocialTags::Inspector do
  it "returns a result from a url" do
    url = "https://example.com"
    actual = SocialTags::Inspector.new(url: url).inspect

    expect(actual.success).must_equal true
    expect(actual.tags.keys).must_equal [:ogs, :tws]
    expect(actual.error).must_be_nil
  end

  it "returns errors from a bad url" do
    url = "https://example.com/404"
    actual = SocialTags::Inspector.new(url: url).inspect

    expect(actual.success).must_equal false
    expect(actual.tags.keys).must_be_empty
    expect(actual.error).must_equal "the server responded with status 404"
  end
end
