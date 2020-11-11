# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Welcomes", type: :system do
  context "ユーザーがログインしていない時" do
    it "ログイン前のページが表示される" do
      visit root_path
      expect(page).to have_content "ご利用にはTwitterアカウントが必要です"
    end
  end
end
