# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "social_tags"

require "minitest/autorun"

class TestConnection < SocialTags::Connection
  def self.build(*)
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.get("https://example.com") { [200, {}, "<html>"] }
    super adapter: [Faraday.default_connection = :test, stubs]
  end
end

class MiniTest::Test
  def before_setup
    super
    SocialTags::Fetcher.connection = TestConnection
  end
end
