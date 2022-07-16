# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "POST /articles", vcr: "twitter_api_get_response" do
    let!(:user) { create(:user) }
    before { login_as user }

    context "いいねしたツイートにURLがある場合" do
      it "flashメッセージが正しいこと" do
        post articles_path

        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq("いいねしたツイートから記事を取得しました。")
      end
    end

    context "いいねしたツイートにURLがない場合" do
      before do
        allow(Article).to receive(:insert_from_tweets).and_return(nil)
      end

      it "flashメッセージが正しいこと" do
        post articles_path
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq("いいねしたツイートの中に記事のURLがありませんでした。")
      end
    end
  end
end
