# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user
    url { "https://example.com" }
    tweet_url { "https://twitter_example.com" }
    tweet_user_meta { "example_meta" }
    tweet_date { 2020-10-30 }
  end
end
