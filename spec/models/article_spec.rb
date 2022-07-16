# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  describe "::insert_from_tweets", vcr: "twitter_api_get_response" do
    let(:user_1) { create(:user) }

    it "ツイートからURLを保存できること" do
      liked_tweets = TwitterApi.new(user_1.access_token, user_1.access_token_secret).fetch_liked_tweets
      Article.insert_from_tweets(liked_tweets, user_1.id)
      expect(user_1.articles.exists?(url: "https://shibaaa647.hatenablog.com/entry/2020/10/05/101550")).to be true
    end

    context "ツイートにあるURLへのスクレイピングでタイムアウトが発生した場合" do
      let!(:timeout_errors) { [Timeout::Error, Net::ReadTimeout] }

      before do
        scrape_mock = double("Scrape")
        allow(scrape_mock).to receive(:access_page).and_raise(timeout_errors.sample)

        allow(Scrape).to receive(:new).and_return(scrape_mock)
      end

      it "処理が続行され、レコードに追加されないこと" do
        liked_tweets = TwitterApi.new(user_1.access_token, user_1.access_token_secret).fetch_liked_tweets
        Article.insert_from_tweets(liked_tweets, user_1.id)
        expect(user_1.articles.exists?(url: "https://shibaaa647.hatenablog.com/entry/2020/10/05/101550")).to be false
      end
    end

    context "取得したツイート全てにURLがない場合" do
      it "nilを返すこと" do
        result = Article.insert_from_tweets([], user_1.id)
        expect(result).to eq nil
      end
    end
  end
end
