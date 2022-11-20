# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "social_tags"

require "minitest/autorun"

def mock
  Minitest::Mock.new
end
