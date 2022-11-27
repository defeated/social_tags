# frozen_string_literal: true

require "test_helper"

describe SocialTags::Connection, "default adapter" do
  it "uses the default adapter" do
    connection = SocialTags::Connection.build
    actual = connection.adapter.name
    expect(actual).must_equal "Faraday::Adapter::NetHttp"
  end
end

describe SocialTags::Connection, "test adapter" do
  before do
    @connection = SocialTags::Connection.build(adapter: :test)
  end

  it "sets http headers" do
    actual = @connection.headers
    expect(actual[:user_agent]).must_equal "SocialTags LinkBot/1.0"
  end

  it "overrides the default adapter" do
    actual = @connection.adapter.name
    expect(actual).must_equal "Faraday::Adapter::Test"
  end

  it "configures middleware" do
    actual = @connection.builder.handlers.map(&:name)
    expect(actual).must_equal ["Faraday::Response::Logger", "Faraday::Response::RaiseError", "Faraday::FollowRedirects::Middleware"]
  end
end
