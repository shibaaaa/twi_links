# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user { nil }
    url { "MyString" }
    tweet_url { "MyString" }
    tweet_user_meta { "MyString" }
  end
end
