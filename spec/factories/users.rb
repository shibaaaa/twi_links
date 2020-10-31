# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "user_1" }
    email { "1@example.com" }
    provider { "twitter" }
    uid { "1" }
    access_token { ENV["ACCESS_TOKEN"] }
    access_token_secret { ENV["ACCESS_TOKEN_SECRET"] }
    password { "password" }
  end
end
