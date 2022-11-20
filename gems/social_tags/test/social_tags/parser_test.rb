# frozen_string_literal: true

require "test_helper"

describe SocialTags::Parser do
  it "parses open graph tags" do
    html = "<head><meta property='og:title' content='The Title'></head>"
    parsed = SocialTags::Parser.new(html: html).parse
    expect(parsed[:ogs]).must_equal "og:title" => "The Title"
  end

  it "parses twitter tags" do
    html = "<head><meta property='twitter:title' content='The Title'></head>"
    parsed = SocialTags::Parser.new(html: html).parse
    expect(parsed[:tws]).must_equal "twitter:title" => "The Title"
  end

  it "ignores other meta tags" do
    html = "<head><meta key='foo' value='bar'></head>"
    parsed = SocialTags::Parser.new(html: html).parse
    expect(parsed[:ogs]).must_be_empty
    expect(parsed[:tws]).must_be_empty
  end

  it "ignores tags outside of head" do
    html = "<body><meta key='foo' value='bar'></body>"
    parsed = SocialTags::Parser.new(html: html).parse
    expect(parsed[:ogs]).must_be_empty
    expect(parsed[:tws]).must_be_empty
  end
end
