# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  describe "#find_or_create_from_tweets", vcr: { cassette_name: "twitter_api_response" } do
    let(:user_1) { create(:user) }

    it "いいねしたツイートからURLを保存できること" do
      Article.find_or_create_from_tweets(user_1)
      expect(user_1.articles.exists?(url: "https://shibaaa647.hatenablog.com/entry/2020/10/05/101550")).to be true
    end
  end
end
