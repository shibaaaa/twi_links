# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :system do
  let(:user_1) { create(:user) }

  before { login_as user_1 }

  describe "記事一覧ページ" do
    it "記事がないこと" do
      visit articles_path
      expect(page).to have_content "まだ記事が登録されていません。"
    end
  end

  describe "記事生成", vcr: "twitter_api_get_response" do
    it "いいねしたツイートから記事を生成" do
      visit articles_path
      find(".button.is-midium.is-info").click
      expect(page).to have_content "2020-10-05"
      expect(page).to have_link "フィヨルドブートキャンプでの学習時間が1000時間を越えました - 柴ブログ"
    end
  end


  describe "記事削除" do
    it "選択した記事が削除される", vcr: "twitter_api_post_response" do
      visit articles_path
      find(".button.is-midium.is-info").click
      page.accept_confirm do
        first(:css, ".fas.fa-trash-alt").click
      end
      expect(page).to have_content "記事を削除しました。"
    end
  end
end
