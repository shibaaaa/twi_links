# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "TwitterのOAuth認証情報からユーザーを作成" do
    let(:user) { User.find_for_twitter_oauth(auth) }
    let(:auth) {
      OmniAuth::AuthHash.new(
        uid: "1",
        provider: "twitter",
        info: { nickname: "user_1" },
        credentials: {
          token: "access_token",
          secret: "access_token_secret"
        }
      )
    }

    it { expect("user_1").to eq user.name }
    it { expect("1").to eq user.uid }
    it { expect("twitter").to eq user.provider }
    it { expect("access_token").to eq user.access_token }
  end
end
