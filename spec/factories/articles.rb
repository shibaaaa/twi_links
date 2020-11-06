# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user
    url { "https://shibaaa647.hatenablog.com/entry/2020/10/05/101550" }
    tweet_url { "https://twitter.com/shibaaa66/status/1312924482009399296" }
    tweet_date { "2020-10-30" }
    tweet_user_meta { "https://pbs.twimg.com/profile_images/1225219657230995456/6g351oag_normal.jpg" }
  end
end
