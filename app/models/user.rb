# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :articles, dependent: :destroy

  def self.find_for_twitter_oauth(auth)
    user = User.where(uid: auth.uid, access_token: auth[:credentials][:token]).first

    unless user
      user = User.create(
        provider:            auth.provider,
        uid:                 auth.uid,
        name:                auth.info.nickname,
        email:               User.dummy_email(auth),
        password:            Devise.friendly_token[0, 20],
        access_token:        auth[:credentials][:token],
        access_token_secret: auth[:credentials][:secret]
      )
    end

    user
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
