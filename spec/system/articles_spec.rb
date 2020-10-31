# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Articles", type: :system do
  let(:user_1) { create(:user) }

  before { login_as user_1 }

  describe "記事一覧", vcr: { cassette_name: "twitter_api_response" } do
    it "user_1の記事が表示される" do
      visit articles_path
      expect(page).to have_content "2020-10-17"
    end
  end
end
