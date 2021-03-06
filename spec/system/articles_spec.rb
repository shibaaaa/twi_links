# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :system do
  let(:user_1) { create(:user) }

  before { login_as user_1 }

  describe "記事一覧ページ" do
    it "記事がないこと" do
      visit articles_path
      expect(page).to have_content "これからブックマークを作成します！"
    end
  end

  describe "記事生成" do
    context "いいねを全て取得できるとき", vcr: "twitter_api_get_response" do
      it "いいねしたツイートから記事を生成" do
        visit articles_path
        click_on "ツイートを読み込む", match: :first
        expect(page).to have_content "2020-10-05"
        expect(page).to have_link "フィヨルドブートキャンプでの学習時間が1000時間を越えました - 柴ブログ"
      end
    end
  end

  describe "記事削除" do
    it "選択した記事が削除される", vcr: "twitter_api_post_response" do
      visit articles_path
      click_on "ツイートを読み込む", match: :first
      page.accept_confirm do
        first(:css, ".fas.fa-trash-alt.trash-icon").click
      end
      expect(page).to have_content "記事を削除しました。"
    end
  end
end
