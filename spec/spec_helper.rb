# frozen_string_literal: true

require "vcr"

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.ignore_hosts "chromedriver.storage.googleapis.com"
  c.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method, :path, :query, :body]
  }
  c.filter_sensitive_data("<API_KEY>") { ENV["TWITTER_API_KEY"] }
  c.filter_sensitive_data("<ACCESS_TOKEN>") { ENV["ACCESS_TOKEN"] }
end
