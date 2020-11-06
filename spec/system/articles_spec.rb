# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :system do
  let(:user_1) { create(:user) }

  before { login_as user_1 }

  describe "記事一覧", vcr: "twitter_api_get_response" do
    it "user_1の記事が表示される" do
      visit articles_path
      expect(page).to have_content "2020-10-05"
      expect(page).to have_link "フィヨルドブートキャンプでの学習時間が1000時間を越えました - 柴ブログ"
    end
  end

  describe "記事削除", vcr: "twitter_api_post_response" do
    it "選択した記事が削除される" do
      visit articles_path
      page.accept_confirm do
        first(:css, ".fas.fa-trash-alt").click
      end
      expect(page).to have_content "記事を削除しました。"
    end
  end
end
