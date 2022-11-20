# frozen_string_literal: true

require_relative "lib/social_tags/version"

Gem::Specification.new do |s|
  s.name = "social_tags"
  s.version = SocialTags::VERSION
  s.authors = ["eddie cianci"]
  s.email = ["defeated2k4@gmail.com"]

  s.summary = "Extract meta data from a webpage."
  s.description = "Tools to parse meta tags and open graph & twitter tags."
  s.homepage = "https://github.com/defeated/social_tags"
  s.license = "MIT"
  s.required_ruby_version = ">= 3.1.2"

  s.require_paths = ["lib"]
  s.files = Dir["lib/**/*", "*.md", "*.txt", "sig/**/*.rbs"]

  s.add_dependency "faraday", "~> 2.7.1"
  s.add_dependency "faraday-http-cache", "~> 2.4.1"
  s.add_dependency "faraday-follow_redirects", "~> 0.3.0"
  s.add_dependency "nokogiri", "~> 1.13.9"
end
