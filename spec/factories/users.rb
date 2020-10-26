# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "user_1" }
    email { "1@example.com" }
    provider { "twitter" }
    uid { "1" }
    access_token { "access_token" }
    access_token_secret { "access_token_secret" }
    password { "password" }
  end
end
