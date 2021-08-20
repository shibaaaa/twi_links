# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :articles, dependent: :destroy

  class << self
    def find_for_twitter_oauth(auth)
      auth_user = User.find_or_create_by(uid: auth.uid, provider: auth. provider) do |user|
        user.name                = auth.info.nickname
        user.email               = dummy_email(auth)
        user.password            = Devise.friendly_token[0, 20]
        user.access_token        = auth[:credentials][:token]
        user.access_token_secret = auth[:credentials][:secret]
      end

      auth_user
    end

    private
      def dummy_email(auth)
        "#{auth.uid}-#{auth.provider}@example.com"
      end
  end
end
